package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.effects.FlxTrail;
import flixel.addons.util.FlxAsyncLoop;
import flixel.addons.util.FlxFSM;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author Daniel Natarelli
 */
class Player extends FlxSprite 
{
	private static inline var GRAVITY:Float = 1400;
	private var fsm:FlxFSM<Player>;
	private var trail:FlxTrail;
	public var graceTime:Float = 0;
	private var direction:Int;
	public var canbeHurted:Bool = true;
	public var backInTime:Bool = false;
	public var jumped:Bool = false;
	private var timeBack:Float = 0;
	private var listPos:Array<FlxPoint>;
	private var timeTrail:Float = 0;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Player__png, true, 30, 48);
		animation.add("idle", [0], 6, true);
		animation.add("run", [0, 1, 2, 3, 4, 5], 12, true);
		animation.add("jump", [6, 7, 8, 9, 10], 12, false);
		acceleration.y = GRAVITY;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.RIGHT;
		direction = 1;
		maxVelocity.set(300, GRAVITY);
		listPos = new Array<FlxPoint>();
		
		fsm = new FlxFSM<Player>(this);
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Idle, Fall, Conditions.falling)
			.add(Jump, Idle, Conditions.grounded)
			.add(Jump, Fall, Conditions.falling)
			.add(Fall, Idle, Conditions.grounded)
			.add(Fall, Jump, Conditions.jumpGrace)
			.start(Idle);
		
		trail = new FlxTrail(this, null, 5, 2,0.4,0.1);
		trail.kill();
		FlxG.state.add(trail);
		health = 3;
	}
	
	override public function update(elapsed:Float):Void 
	{
		fsm.update(elapsed);
		if (!backInTime)
		{
			super.update(elapsed);
			clampPositions();
		}
		else
		{
			timeBack += elapsed;
			if (timeBack > 0.01)
			{
				getBackInTime();
				timeBack = 0;
			}
		}
		if (trail.alive)
			timeTrail += elapsed;
		if (timeTrail > 3)
		{
			setTrail();
			timeTrail = 0;
		}
	}
	private function clampPositions():Void
	{
		if (listPos.length > 100)
			listPos.shift();
	}
	
	private function getBackInTime():Void
	{
		if (listPos.length > 0)
		{
			var pos:FlxPoint = listPos.pop();
			setPosition(pos.x, pos.y);
			allowCollisions = FlxObject.NONE;
		}
		else
		{
			setPosition(x, y-32);
			canGetDamage();
		}
	}
	
	public function setTrail():Void 
	{
		if (trail.alive == false)
			trail.revive();
		else
			trail.kill();
	}
	
	public function movement():Void
	{
		if ((FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT) && canbeHurted)
		{
			if(velocity.y!=0)
				velocity.x = FlxG.keys.pressed.LEFT ? -200 :200;
			else
				velocity.x = FlxG.keys.pressed.LEFT ? -250 :250;
			direction = (velocity.x >= 0) ? 1 : -1;
			animation.play("run");
			listPos.push(getPosition());
		}
		else
		{
			velocity.x = 0;
			if (velocity.y != 0)
				animation.play("jump");
			else
			{
				animation.play("idle");
			}
		}
		facing = (direction == 1) ? FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	public function getDamage():Void
	{
		if (health > 0)
		{
			if (canbeHurted)
			{
				health -= 1;
				canbeHurted = false;
				FlxFlicker.flicker(this, 3, 0.1, true, true,endFlicker);
			}
		}
		else
		{
			Global.tutorialCompletado = true;
			FlxG.resetState();
		}
	}
	
	private function endFlicker(f:FlxFlicker):Void
	{
		canGetDamage();
	}
	
	private function canGetDamage():Void 
	{
		canbeHurted = true;
		backInTime = false;
		allowCollisions = FlxObject.ANY;
	}
	
	public function timeDamage():Void
	{
		getDamage();
		backInTime = true;
	}
	
	public function getDirection():Int
	{
		return direction;
	}
}

class Conditions
{
	public static function jump(owner:Player):Bool
	{
		return (FlxG.keys.justPressed.UP && owner.isTouching(FlxObject.FLOOR) && owner.canbeHurted);
	}
	
	public static function grounded(owner:Player):Bool
	{
		return owner.isTouching(FlxObject.FLOOR);
	}
	
	public static function falling(owner:Player):Bool
	{
		return (owner.velocity.y > 0 && !owner.isTouching(FlxObject.FLOOR));
	}
	
	public static function jumpGrace(owner:Player):Bool
	{
		return (FlxG.keys.justPressed.UP && owner.graceTime < 0.15 && !owner.jumped);
	}
	
	public static function animationFinished(owner:Player):Bool
	{
		return owner.animation.finished;
	}
}


class Idle extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void
	{
		owner.jumped = false;
	}
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.velocity.x = 0;
		owner.movement();
	}
}

class Jump extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void
	{
		owner.velocity.y = -525;
		owner.jumped = true;
		owner.animation.play("jump");
	}
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.movement();
	}
}

class Fall extends FlxFSMState<Player>
{
	override public function enter(owner:Player, fsm:FlxFSM<Player>):Void
	{
		owner.graceTime = 0;
		owner.animation.play("jump");
	}
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.movement();
		owner.graceTime += elapsed;
	}
}
