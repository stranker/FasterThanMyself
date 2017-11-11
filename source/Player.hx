package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.effects.FlxTrail;
import flixel.addons.util.FlxFSM;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Daniel Natarelli
 */
class Player extends FlxSprite 
{
	private static inline var GRAVITY:Float = 1400;
	private static inline var VEL:Int = 300;
	private var fsm:FlxFSM<Player>;
	private var trail:FlxTrail;
	public var graceTime:Float = 0;
	private var graceJump:Bool;
	//private var
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.BLUE);
		acceleration.y = GRAVITY;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.RIGHT;
		maxVelocity.set(VEL, GRAVITY);
		
		fsm = new FlxFSM<Player>(this);
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Idle, Fall, Conditions.falling)
			.add(Jump, Idle, Conditions.grounded)
			.add(Jump, Fall, Conditions.falling)
			.add(Fall, Idle, Conditions.grounded)
			.start(Idle);
		
		trail = new FlxTrail(this, null, 5, 2, 0.4, 0.05);
		FlxG.state.add(trail);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		fsm.update(elapsed);
		super.update(elapsed);
		//trace(Type.getClassName(fsm.stateClass)); ESTADO
		trace(graceTime);
		if (graceTime > 0.2)
			graceJump = false;
		else
			graceJump = true;
	}
	
	public function movement():Void
	{
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			velocity.x = FlxG.keys.pressed.LEFT ? -VEL : VEL;
			// ANIMACION animation.play("run");
		}
		else
		{
			velocity.x = 0;
			// ANIMACION animation.play("idle");
		}
		facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	public function hadGraceJump():Bool
	{
		return graceJump;
	}
	
	
}

class Conditions
{
	public static function jump(owner:Player):Bool
	{
		return (FlxG.keys.justPressed.UP && (owner.isTouching(FlxObject.FLOOR) || owner.hadGraceJump()));
	}
	
	public static function grounded(owner:Player):Bool
	{
		return owner.isTouching(FlxObject.FLOOR);
	}
	
	public static function falling(owner:Player):Bool
	{
		return (owner.velocity.y > 0 && !owner.isTouching(FlxObject.FLOOR));
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
		// animacion play (jump)
		owner.velocity.y = -500;
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