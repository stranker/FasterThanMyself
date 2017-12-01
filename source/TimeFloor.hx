package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class TimeFloor extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.TimeFloor__png, true, 32, 32);
		animation.add("idle", [0, 1, 2, 3], 6 , true);
		animation.play("idle");
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.overlap(this, Global.player))
			Global.player.timeDamage();
		super.update(elapsed);
	}
	
}