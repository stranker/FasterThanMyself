package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class TimePulser extends FlxSprite 
{
	private var shotTime:Float = 0;
	private var direction:Int = 1;
	public function new(?X:Float=0, ?Y:Float=0, ?dir:Int=1) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFFFFFF00);
		direction = dir;
		immovable = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		shotTime += elapsed;
		if (shotTime > 4)
		{
			var p:Pulse = new Pulse(x + width / 2, y + height / 2, direction);
			FlxG.state.add(p);
			shotTime = 0;
		}
		FlxG.collide(this, Global.player);
	}
	
}