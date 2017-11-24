package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */
class TimeWall extends FlxSprite 
{
	private var timeVelocity:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.TimeWall__png, true, 20, 32);
		animation.add("idle", [0, 1, 2], 6);
		//velocity.x = 50;
		pixelPerfectPosition = false;
		animation.play("idle");
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.player, playerCollide);
		Global.timeWallPos = x;
		//velocity.x = Global.timeWallSpeed;
		if (velocity.x < 50)
			timeVelocity += elapsed;
		if (timeVelocity>3) 
		{
			Global.timeWallSpeed = 50;
			timeVelocity = 0;
		}
	}
	
	private function playerCollide(t:TimeWall,p:Player):Void
	{
		FlxG.resetState();
	}
	
}