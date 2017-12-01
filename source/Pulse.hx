package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author Yope
 */
class Pulse extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?direction:Int=1) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Pulse__png, true, 8, 8);
		animation.add("fly", [0, 1, 2, 3, 4], 6, true);
		velocity.x = 100 * direction;
		x = x - width / 2;
		y = y - height / 2;
		animation.play("fly");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(Global.player, this, playerOverlap);
		FlxG.collide(Global.tilemap, this, tilemapCollide);
	}
	
	private function tilemapCollide(t:FlxTilemap,pulse:Pulse):Void 
	{
		pulse.destroy();
	}
	
	private function playerOverlap(p:Player,pulse:Pulse):Void 
	{
		p.getDamage();
		pulse.destroy();
	}
}