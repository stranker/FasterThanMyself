package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class CollectableEnd extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16, 0xFFFFFF00);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.player, playerOverlap);
	}
	
	private function playerOverlap(c:CollectableEnd,p:Player):Void 
	{
		c.destroy();
		//Global.currLevel ++;
		//FlxG.switchState(new PlayState());
	}
	
}