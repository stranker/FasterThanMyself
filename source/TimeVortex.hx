package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class TimeVortex extends FlxSprite 
{
	private var timerActivo:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFF4d4d4d);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		timerActivo += elapsed;
		if (timerActivo > 3)
		{
			FlxG.overlap(this, Global.player, playerOverlap);
			color = 0xFF00FF00;
		}
		if (timerActivo > 6)
		{
			timerActivo = 0;
			color = 0xFF4d4d4d;
		}
	}
	
	private function playerOverlap(v:TimeVortex,p:Player):Void
	{
		p.getDamage();
	}
	
}