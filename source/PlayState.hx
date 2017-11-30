package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var timeBar:LevelBar;
	private var levelList:Array<String>;
	override public function create():Void
	{
		super.create();	
		Global.timeWallPos = 0;
		Global.timeWallSpeed = 50;
		levelList = new Array();
		addLevels();
		init();
	}
	
	private function init():Void
	{
		tilemap = new FlxTilemap();
		loader = new FlxOgmoLoader(levelList[Global.currLevel]);
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
	
	private function addLevels():Void 
	{
		levelList = [AssetPaths.test__oel,AssetPaths.Level1__oel];
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
			case "TimePulser":
				var tp:TimePulser = new TimePulser(x, y, Std.parseInt(entityData.get("direction")));
				add(tp);
			case "TimeFloor":
				var tf:TimeFloor = new TimeFloor(x, y);
				add(tf);
			case "TutorialText":
				var tt:TutorialText = new TutorialText(x, y, 160, "HOLA XD", 8, true, Std.parseInt(entityData.get("tipo")));
				add(tt);
		}
	}
	
}