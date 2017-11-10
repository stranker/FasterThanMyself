package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var p:Player;
	var platform:FlxSprite;
	override public function create():Void
	{
		super.create();
		p = new Player(FlxG.camera.width / 2, FlxG.camera.height / 2);
		platform = new FlxSprite(150, 500);
		platform.makeGraphic(500, 20, 0xFFFF00FF);
		platform.immovable = true;
		add(platform);
		add(p);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(p, platform);
		super.update(elapsed);
	}
}