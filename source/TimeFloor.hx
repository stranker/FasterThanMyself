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
		makeGraphic(32, 32, 0xFFFF8000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.overlap(this, Global.player))
			Global.player.timeDamage();
		super.update(elapsed);
	}
	
}