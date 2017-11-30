package;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */
class Global 
{
	static public var player:Player;
	static public var timeWallPos:Float;
	static public var timeWallSpeed:Float;
	static public var tilemap:FlxTilemap;
	static public var currLevel:Int = 0;
	static public var boulderGroup:FlxTypedGroup<Boulder>;
}