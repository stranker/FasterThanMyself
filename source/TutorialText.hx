package;

import flixel.addons.text.FlxTypeText;

/**
 * ...
 * @author ...
 */
class TutorialText extends FlxTypeText 
{
	private var tipo:Int = 0;
	public function new(X:Float, Y:Float, Width:Int, Text:String, Size:Int=8, EmbeddedFont:Bool=true, ?tip:Int=0) 
	{
		super(X, Y, Width, Text, Size, EmbeddedFont);
		tipo = tip;
		setTipo();
	}
	
	private function setTipo():Void 
	{
		switch (tipo) 
		{
			case 0:
				resetText("Hola mi amiguio xd");
			default:
				
		}
		start(0.02, false, false);
	}
	
}