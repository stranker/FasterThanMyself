package;

import flixel.FlxG;
import flixel.FlxObject;
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
		loadGraphic(AssetPaths.TimePulse__png, true, 32, 32);
		animation.add("idle", [0, 1], 6, true);
		animation.add("shot", [0, 1, 2, 3, 4], 6, false);
		animation.play("idle");
		direction = dir;
		immovable = true;
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		if (direction == 1)
			facing = FlxObject.RIGHT;
		else
			facing = FlxObject.LEFT;
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
			animation.play("shot");
		}
		else
			animation.play("idle");
		FlxG.collide(this, Global.player);
	}
	
}