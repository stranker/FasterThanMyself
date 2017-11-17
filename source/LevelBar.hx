package;

import flixel.tile.FlxTilemap;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;

/**
 * ...
 * @author ...
 */
class LevelBar extends FlxBar 
{

	public function new(x:Float=0, y:Float=0,tilemap:FlxTilemap) 
	{
		var parentRef:Dynamic = Global.player;
		var variable:String = "x";
		var directionB:FlxBarFillDirection = FlxBarFillDirection.LEFT_TO_RIGHT;
		var widthB:Int = 720;
		var heightB:Int = 20;
		var minB:Float = 0;
		var maxB:Float = tilemap.width;
		super(x, y, directionB, widthB, heightB, parentRef, variable, minB, maxB);
		scrollFactor.set(0, 0);
		numDivisions = 1000;
	}
	
}