package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;

/**
 * ...
 * @author Esa Karjalainen
 */
class TestEntity extends Entity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		sprite = new Spritemap(Asset.graphics("uisprites.png"), 16, 16);		
		sprite.add("aa", [0, 1, 2, 3], 4, true);
		//
		//this.set_layer(0);
		this.graphic = sprite;
		
		sprite.play("aa");
		//addGraphic(this.graphic);
		//var foo = addGraphic(new Image(Asset.graphics("Button.png"))); 		
	}
	
	
	private var sprite:Spritemap;
}