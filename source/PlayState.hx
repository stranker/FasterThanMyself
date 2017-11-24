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
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var timeBar:LevelBar;
	override public function create():Void
	{
		Global.timeWallPos = 0;
		Global.timeWallSpeed = 50;
		super.create();		
		tilemap = new FlxTilemap();
		loader = new FlxOgmoLoader(AssetPaths.test__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "Tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		loader.loadEntities(placeEntities, "Entities");
		Global.tilemap = tilemap;
		
		timeBar = new LevelBar(100, FlxG.height - 50, tilemap);
		
		add(tilemap);
		add(timeBar);
		add(timeBar.playerHead);
		add(timeBar.timeWall);
		FlxG.camera.follow(Global.player, FlxCameraFollowStyle.PLATFORMER, 3);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(Global.player, tilemap);
		super.update(elapsed);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch (entityName)
		{
			case "Player":
				var p:Player = new Player(x, y);
				Global.player = p;
				add(p);
			case "Clock":
				var c:Clock = new Clock(x, y);
				add(c);
			case "TimeWall":
				var t:TimeWall = new TimeWall(x, y);
				add(t);
			case "TimeVortex":
				var t:TimeVortex = new TimeVortex(x, y);
				add(t);
			case "CollectableEnd":
				var c:CollectableEnd = new CollectableEnd(x, y);
				add(c);
		}
	}
}