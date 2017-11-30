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
		makeGraphic(8, 8, 0xFFFFFF00);
		velocity.x = 100 * direction;
		x = x - width / 2;
		y = y - height / 2;
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