package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Clock extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Clock__png, false, 26, 26);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(Global.player, this, pickClock);
	}
	
	private function pickClock(p:Player,c:Clock):Void 
	{
		Global.timeWallSpeed = 30;
		Global.player.setTrail();
		destroy();
	}
	
}