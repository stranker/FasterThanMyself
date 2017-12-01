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
	var than:FlxText;
	var faster:FlxText;
	var myself:FlxText;
	override public function create():Void 
	{
		super.create();
		faster = new FlxText(250, FlxG.height / 2 - 200, 500 , "Faster", 50, true);
		than = new FlxText(350, FlxG.height / 2 - 100, 500 , "than", 50, true);
		myself = new FlxText(450, FlxG.height / 2, 500 , "myself", 50, true);
		faster.color = 0xffff0097;
		than.color = 0xFF808080;
		myself.color = 0xFF00E5E5;
		faster.alpha = 0;
		than.alpha = 0;
		myself.alpha = 0;
		add(faster);
		add(than);
		add(myself);
		FlxTween.tween(faster, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(than, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(myself, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn, onComplete:mostrarNombre});
	}
	
	private function mostrarNombre(f:FlxTween):Void
	{
		var dani:FlxText = new FlxText(200, FlxG.height / 2 +200, 1000 , "Daniel H. Natarelli", 50, true);
		add(dani);
		dani.alpha = 0;
		FlxTween.tween(dani, {alpha:1}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(faster, {alpha:0}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(than, {alpha:0}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn});
		FlxTween.tween(myself, {alpha:0}, 3, {type:FlxTween.PERSIST, ease:FlxEase.cubeIn, onComplete:nextState});
	}
	
	private function nextState(f:FlxTween):Void
	{
		FlxG.switchState(new HistoryState());
	}
	
}