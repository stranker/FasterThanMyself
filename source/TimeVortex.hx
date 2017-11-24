package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class TimeVortex extends FlxSprite 
{
	private var timerActivo:Float = 0;
	private var particulas:FlxEmitter;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFF4d4d4d);
		particulas = new FlxEmitter(x + width/2, y + height / 2,50);
		particulas.makeParticles(2, 2, 0xFFFF00FF,50);
		particulas.velocity.set(50, -50, 50, 50);
		particulas.launchAngle.set( -180, 180);
		FlxG.state.add(particulas);
		particulas.start(false, 0.01);
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
		timerActivo += elapsed;
		if (timerActivo > 2)
			particulas.emitting = false;
		if (timerActivo > 3)
		{
			FlxG.overlap(this, Global.player, playerOverlap);
			color = 0xFF00FF00;
		}
		if (timerActivo > 6)
		{
			particulas.emitting = true;
			timerActivo = 0;
			color = 0xFF4d4d4d;
		}
	}
	
	private function playerOverlap(v:TimeVortex,p:Player):Void
	{
		p.getDamage();
	}
	
}