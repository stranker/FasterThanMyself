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
		loadGraphic(AssetPaths.TimeVortex__png, true, 32, 32);
		animation.add("d", [0, 1, 2, 3], 6, false);
		animation.add("nd", [4, 5, 6, 7], 6, true);
		particulas = new FlxEmitter(x + width/2, y + height / 2,50);
		particulas.loadParticles(AssetPaths.Particula__png,50,16,false,false);
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
			animation.play("d");
		}
		if (timerActivo > 6)
		{
			particulas.emitting = true;
			timerActivo = 0;
			animation.play("nd");
		}
	}
	
	private function playerOverlap(v:TimeVortex,p:Player):Void
	{
		p.timeDamage();
	}
	
}