package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Yope
 */
class Boulder extends FlxSprite 
{
	private var tilemapColliding:Bool = false;
	private var isMoving:Bool = false;
	private var boulderColliding:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFFFF8000);
	}
	override public function update(elapsed:Float):Void 
	{
		
		if	(FlxG.collide(Global.boulderGroup, this))
			boulderColliding = true;
		else
			boulderColliding = false;
		if (FlxG.collide(Global.tilemap, this))
			tilemapColliding = true;
		else
			tilemapColliding = false;
		FlxG.overlap(Global.player, this, playerCollide);
		super.update(elapsed);
	}

	private function playerCollide(p:Player,b:Boulder):Void
	{
		if (!isMoving && !tilemapColliding && !boulderColliding)
		{
			isMoving = true;
			FlxTween.tween(this, {x:x + width * Global.player.getDirection()}, 0.5, {type:FlxTween.ONESHOT, ease:FlxEase.cubeOut, onComplete:canMove});
		}
		p.setPosition(x + width *-Global.player.getDirection(), p.y);
	}
	
	private function canMove(tween:FlxTween):Void 
	{
		isMoving = false;
	}
	
}