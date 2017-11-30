package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Yope
 */
class Boulder extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(32, 32, 0xFFFF8000);
	}
	override public function update(elapsed:Float):Void 
	{
		FlxG.collide(Global.tilemap, this);
		FlxG.overlap(Global.player, this, playerCollide);
		
		super.update(elapsed);
	}

	private function playerCollide(p:Player,b:Boulder):Void
	{
		FlxTween.tween(this, {x:x + width * Global.player.getDirection()}, 0.5, {type:FlxTween.PERSIST, ease:FlxEase.cubeOut});
		p.setPosition(x + width *-Global.player.getDirection(),p.y);
	}
	
}