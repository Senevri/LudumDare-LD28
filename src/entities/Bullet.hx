package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
import com.haxepunk.masks.Imagemask;
import com.haxepunk.Sfx;
import scenes.Cinematic;
import com.haxepunk.HXP;


/**
 * ...
 * @author Esa Karjalainen
 */
class Bullet extends Entity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		var image = new Image(Asset.graphics("bullet.png"));
		graphic = image;
		mask = new Imagemask(image);		
		super(x, y, graphic, mask);
		this.type = "bullet";
		
		//addGraphic(new Image(Asset.graphics("bullet.png"))); 		
	}
	
	override public function update():Void 
	{
		super.update();
		moveAtAngle(angle, velocity);
		var entity = collide("creature", x, y);
		if (null != entity) {
			var creature:Creature = cast entity;
			
			if (entity.name == "Player") {
				scene.remove(this);				
				creature.ammo += 1;
			} else {
				var foo = new Sfx(Asset.sfx("hit.wav"));
				foo.play();
				creature.health -= this.power;
				if (creature.health == 0) {
					foo = new Sfx(Asset.sfx("hit.wav"));
					foo.play();
					scene.remove(creature);
					scene.add(new Powerup(creature.x + creature.halfWidth, creature.y + creature.halfHeight));
					if (creature.name == "spider") {
						//HXP.scene.
						HXP.scene = new Cinematic("anim_placeholder", 400, 240, 10, 1);
						HXP.swapScene();
					}
				}
			//scene.remove(entity);
			}
			this.angle = 180 + (90 - (angle % 90)) + (Math.random() -0.5) * 30;
		}
				
		var entity = collide("area", x, y);
		
		
		if (null != entity) {
			var area:TmxArea = cast entity;
			//trace(entity.type);
			if (entity.name=="ground") {
				//this.velocity = 0;
				this.angle = Std.parseFloat(area.properties.get("direction")) + (90 - (angle % 90));
			}
			
			
			if (entity.name == "wall") {
				this.angle = Std.parseFloat(area.properties.get("direction")) + (90 - (angle % 90));												
			}
		}
	
	}
	
	
	
	private var sprite:Spritemap;
	public var power = 1;
	public var velocity:Float;
	public var angle: Float;
}