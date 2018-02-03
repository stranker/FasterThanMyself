package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author ...
 */
class CollectableEnd extends FlxSprite 
{
	var tipo:Int = 1;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		set_image();
		FlxTween.tween(this, {y:y + 16}, 2, {type:FlxTween.PINGPONG, ease:FlxEase.linear});
	}
	
	private function set_image():Void 
	{
		switch (tipo) 
		{
			case 0:
				loadGraphic(AssetPaths.Rubick__png, false, 16, 16);
			case 1:
				loadGraphic(AssetPaths.Cassette__png, false, 16, 16);
			default:
				makeGraphic(16, 16, 0xFFFF00FF);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Global.player, playerOverlap);
	}
	
	private function playerOverlap(c:CollectableEnd,p:Player):Void 
	{
		FlxG.camera.flash(0xFFFFFFFF,2,nextLevel);
		c.destroy();
		Global.currLevel ++;
	}
	
	private function nextLevel():Void
	{
		FlxG.switchState(new PlayState());
	}
	
}