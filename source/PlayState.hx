package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var timeBar:LevelBar;
	private var levelList:Array<String>;
	override public function create():Void
	{
		super.create();	
		levelList = new Array();
		addLevels();
		init();
	}
	
	private function init():Void
	{
		Global.timeWallPos = 0;
		Global.timeWallSpeed = 0;
		loader = new FlxOgmoLoader(levelList[Global.currLevel]);
		tilemap = new FlxTilemap();
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "Tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		Global.tilemap = tilemap;
		timeBar = new LevelBar(230, FlxG.camera.height - 180, tilemap);
		add(tilemap);
		loader.loadEntities(placeEntities, "Entities");
		add(timeBar);
		add(timeBar.playerHead);
		add(timeBar.timeWall);
		FlxG.camera.follow(Global.player, FlxCameraFollowStyle.NO_DEAD_ZONE, 3);
		FlxG.camera.zoom = 1.5;
		FlxG.camera.followLerp = 0.2;
		FlxG.camera.flash(FlxColor.WHITE, 2);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
	}
	
	private function addLevels():Void 
	{
		levelList = [AssetPaths.Level1__oel,AssetPaths.Level2__oel,AssetPaths.Level3__oel,AssetPaths.Level4__oel,AssetPaths.EndLevel__oel];
	}
	
	override public function update(elapsed:Float):Void 
	{
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
				var tt:TutorialText = new TutorialText(x, y, Std.parseInt(entityData.get("tipo")));
				add(tt);
		}
	}
	
}