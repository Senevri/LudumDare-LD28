package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;

/**
 * ...
 * @author Esa Karjalainen
 */
class TmxAnimatedObject extends Entity
{
		
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);		
	}
	
	public function addSprites(imageSource:String, width=0, height=0, ?startFrame = 0, ?count = 1) 
	{
		//trace(Asset.graphics(imageSource));
		sprite = new Spritemap(Asset.graphics(imageSource), width, height);
		//trace([for (i in startFrame...count - 1) i]);
		sprite.add("default", [for (i in startFrame...count) i], 12, true);
		sprite.play("default");
		//trace ("framecount " + sprite.frameCount + " frame " + sprite.frame + " current " + sprite.currentAnim);
		graphic = sprite;
				
		
	}
	public function addAnimations(anims:Map < String, Array<Int> > , ?rate:Int=10)
	{
		for (name in anims.keys()) {
			sprite.add(name, anims[name], rate);
		}
	}
	
	public override function update() 
	{
		super.update();
		if (sprite.currentAnim != "foo") {
			//sprite.play("foo");			
		}
	}
	
	private var sprite:Spritemap;
	//public var name:String; //apparently exists by default?
}