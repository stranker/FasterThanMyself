package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;

/**
 * ...
 * @author ...
 */
class LevelBar extends FlxBar 
{
	public var playerHead(get, null):FlxSprite;
	public var timeWall(get, null):FlxSprite;

	public function new(x:Float=0, y:Float=0,tilemap:FlxTilemap) 
	{
		playerHead = new FlxSprite(x, y, AssetPaths.Head__png);
		playerHead.scale.set(2, 2);
		timeWall = new FlxSprite(x, y, null);
		timeWall.loadGraphic(AssetPaths.TimeWall__png, true, 20, 32);
		timeWall.animation.add("idle", [0, 1, 2], 6, true);
		timeWall.scale.set(2, 2);
		timeWall.animation.play("idle");
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
		playerHead.scrollFactor.set(0, 0);
		timeWall.scrollFactor.set(0, 0);
	}
	
	function get_playerHead():FlxSprite 
	{
		return playerHead;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		playerHead.x = x - 5 + value/(max/720);
		playerHead.y = y - 3;
		timeWall.x = x + Global.timeWallPos / (max / 720);
		timeWall.y = y - 5;
	}
	
	function get_timeWall():FlxSprite 
	{
		return timeWall;
	}
	
}