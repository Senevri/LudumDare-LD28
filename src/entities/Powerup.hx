package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Imagemask;
import com.haxepunk.Mask;
import Asset;
import com.haxepunk.Sfx;

/**
 * ...
 * @author Esa Karjalainen
 */
class Powerup extends Entity
{

	//how to do this....
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		var image = null; 
		if (null == graphic) { 
			image = new Image(Asset.graphics("powerup_placeholder.png"));
			graphic = image;
		} else {
			image = new Image(graphic);
		}
		mask = new Imagemask(image);
		super(x, y, graphic, mask);
		this.type = "powerup";		
		this.angle = 270;
		this.velocity = 1;
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
				var foo = new Sfx(Asset.sfx("powerup.wav"));
				foo.play();
				creature.powerups.push(this);
			}
		}
	}
	
	public var velocity:Float;
	public var angle: Float;
	
}