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
	var directionB:FlxBarFillDirection;
	public var playerHead(get, null):FlxSprite;
	public var timeWall(get, null):FlxSprite;

	public function new(x:Float=0, y:Float=0,tilemap:FlxTilemap) 
	{
		playerHead = new FlxSprite(x, y, AssetPaths.Head__png);
		playerHead.scale.set(1.4, 1.4);
		timeWall = new FlxSprite(x, y, null);
		timeWall.loadGraphic(AssetPaths.TimeWall__png, true, 20, 32);
		timeWall.animation.add("idle", [0, 1, 2], 6, true);
		timeWall.animation.play("idle");
		timeWall.scale.set(1.4, 1.4);
		var parentRef:Dynamic = Global.player;
		var variable:String = "x";
		if(Global.timeWallDirection==1)
			directionB = FlxBarFillDirection.LEFT_TO_RIGHT;
		else
			directionB = FlxBarFillDirection.RIGHT_TO_LEFT;
		var widthB:Int = 500;
		var heightB:Int = 20;
		var minB:Float = 0;
		var maxB:Float = tilemap.width;
		super(x, y, directionB, widthB, heightB, parentRef, variable, minB, maxB);
		scrollFactor.set(0, 0);
		numDivisions = 1000;
		playerHead.scrollFactor.set(0, 0);
		timeWall.scrollFactor.set(0, 0);
		createColoredEmptyBar(0xFF02ffec, true, 0xFF4b86b4);
		createColoredFilledBar(0x00000000, false);
		value = 0;
		if (Global.timeWallDirection == 1)
			Global.timeWallPos = 0;
		else
			Global.timeWallPos = FlxG.camera.width;
	}
	
	function get_playerHead():FlxSprite 
	{
		return playerHead;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		playerHead.x = x + Global.player.x/ (max/500) - playerHead.width/2;
		playerHead.y = y - 3;
		timeWall.x = x + Global.timeWallPos / (max / 500) - timeWall.width/2;
		timeWall.y = y - 5;
	}
	
	function get_timeWall():FlxSprite 
	{
		return timeWall;
	}
	
}