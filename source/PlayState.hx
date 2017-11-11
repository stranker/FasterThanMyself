package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;

class PlayState extends FlxState
{
	var p:Player;
	var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var timeBar:FlxBar;
	private var countdown:Float;
	override public function create():Void
	{
		super.create();
		p = new Player(FlxG.camera.width / 2, FlxG.camera.height / 2);
		tilemap = new FlxTilemap();
		loader = new FlxOgmoLoader(AssetPaths.test__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "Tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		
		countdown = 60;
		
		timeBar = new FlxBar(100, FlxG.camera.height - 20,FlxBarFillDirection.RIGHT_TO_LEFT, 760, 10, this, "countdown", 0, 60);
		timeBar.numDivisions = 1000;
		timeBar.scrollFactor.set(0, 0);
		
		add(tilemap);
		add(p);
		add(timeBar);
		FlxG.camera.follow(p, FlxCameraFollowStyle.PLATFORMER, 3);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(p, tilemap);
		super.update(elapsed);
		countdown -= elapsed;
	}
}