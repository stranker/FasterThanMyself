package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Yope
 */
class HistoryState extends FlxState 
{
	var texto:FlxTypeText;
	var stopAct:Bool = false;
	var stopTime:Float = 0;

	override public function create():Void 
	{
		super.create();
		texto = new FlxTypeText(10, 10, FlxG.camera.width - 10, " No sé como sucedió. Lo último que recuerdo es haber estado en mi taller, arreglando mi televisor. Lo siguiente fue blanco. Sentia un cosquilleo en mi cuerpo que no sabia describir y mis piernas temblaban. Pero creo que algo puedo contarte...", 20, true);
		add(texto);
		texto.start(0.1, false,false,null,eraseText);
	}
	
	private function eraseText():Void
	{
		stopAct = true;
	}
	
	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (stopAct)
			stopTime += elapsed;
		if (stopTime > 3)
			borrarTexto();
	}
	
	private function borrarTexto():Void
	{
		texto.erase(0.05,false,null,gameState);
	}
	
	private function gameState():Void 
	{
		FlxG.switchState(new PlayState());
	}
}