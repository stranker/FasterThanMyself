package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;

/**
 * ...
 * @author ...
 */
class TutorialText extends FlxSprite 
{
	private var activado:Bool = false;
	private var textoLoco:flixel.addons.text.FlxTypeText;
	private var eraseTime:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0,?tip:Int=0) 
	{
		super(X, Y);
		makeGraphic(128, 128, 0x00FF8000);
		textoLoco = new FlxTypeText(X, Y, 200, "", 12, true);
		FlxG.state.add(textoLoco);
		setTipo(tip);
	}
	
	private function setTipo(tipo:Int):Void 
	{
		switch (tipo) 
		{
			case 0:
				if(!Global.tutorialCompletado)
					textoLoco.resetText("Utiliza las flechas para moverte");
				else
					textoLoco.resetText("Creo que ya sabes como moverte");
			case 1:
				if(!Global.tutorialCompletado)
					textoLoco.resetText("El reloj aumenta tu velocidad");
				else
					textoLoco.resetText("Tic Toc Tic Toc");
			case 2:
				if(!Global.tutorialCompletado)
					textoLoco.resetText("Algunos obstaculos pueden afectar tu estado temporal");
				else
					textoLoco.resetText("¿Dificil?");
			case 3:
				if(!Global.tutorialCompletado)
					textoLoco.resetText("Si perdes todas tus vidas se reinicia el plano temporal");
				else
					textoLoco.resetText("No te desalientes, continua hasta el final");
			case 4:
				textoLoco.resetText("¡Viaja a traves del tiempo recolectando recuerdos del pasado!");
			case 5:
				textoLoco.resetText("Todo parece tranquilo...");
			case 6:
				textoLoco.resetText("¡Un vortex temporal! Ten cuidado que son muy inestables");
			default:
				
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		FlxG.overlap(Global.player, this, playerCollide);
		super.update(elapsed);
		if (activado)
			eraseTime += elapsed;
		if (eraseTime > 5)
		{
			textoLoco.erase(0.02, false);
			eraseTime = 0;
		}
	}
	
	private function playerCollide(p:Player,te:TutorialText):Void
	{
		if (!activado)
		{
			activado = true;
			textoLoco.start(0.01, false, false);
		}
	}
	
}