package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Yope
 */
class Splash extends FlxState 
{
	override public function create():Void 
	{
		super.create();
		var faster:FlxText = new FlxText(200, FlxG.height / 2 - 200, 500 , "Faster", 50, true);
		var than:FlxText = new FlxText(300, FlxG.height / 2 - 100, 500 , "than", 50, true);
		var myself:FlxText = new FlxText(400, FlxG.height / 2, 500 , "myself", 50, true);
		faster.alpha = 0;
		than.alpha = 0;
		myself.alpha = 0;
		add(faster);
		add(than);
		add(myself);
		FlxTween.tween(faster, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(than, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(myself, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
	}
	
}