package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.effects.FlxTrail;
import flixel.addons.util.FlxFSM;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
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
	private var canbeHurted:Bool = true;
	public var jumped = false;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Player__png, true, 30, 48);
		animation.add("idle", [0], 6, true);
		animation.add("run", [0, 1, 2, 3,4,5], 12, true);
		acceleration.y = GRAVITY;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.RIGHT;
		direction = 1;
		maxVelocity.set(Global.countdown*5, GRAVITY);
		
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
		wallDamage();
		super.update(elapsed);

		//trace(Type.getClassName(fsm.stateClass)); ESTADO
	}
	
	private function wallDamage():Void 
	{
		if (Global.timeWallSpeed < 50)
			trail.revive();
		else
			trail.kill();
	}
	
	public function movement():Void
	{
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			velocity.x = FlxG.keys.pressed.LEFT ? -Global.countdown*5 : Global.countdown*5;
			direction = (velocity.x >= 0) ? 1 : -1;
			animation.play("run");
		}
		else
		{
			velocity.x = 0;
			animation.play("idle");
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
				FlxFlicker.flicker(this, 3, 0.1, true, true, canGetDamage);
			}
		}
		else
		{
			FlxG.resetState();
		}
	}
	
	private function canGetDamage(f:FlxFlicker):Void 
	{
		canbeHurted = true;
	}
}

class Conditions
{
	public static function jump(owner:Player):Bool
	{
		return (FlxG.keys.justPressed.UP && owner.isTouching(FlxObject.FLOOR));
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
		owner.velocity.y = -500;
		owner.jumped = true;
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
	}
	override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
	{
		owner.movement();
		owner.graceTime += elapsed;
	}
}