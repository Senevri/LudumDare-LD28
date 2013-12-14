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
	
	
	
	public function addSprites(imageSource:String, width=0, height=0, ?startFrame = 0, ?count = 1, ?name="default") 
	{
		//trace(Asset.graphics(imageSource));
		sprite = new Spritemap(Asset.graphics(imageSource), width, height);
		//trace([for (i in startFrame...count - 1) i]);
		sprite.add(name, [for (i in startFrame...count) i], 10, true);
		sprite.play(name);
		//trace ("framecount " + sprite.frameCount + " frame " + sprite.frame + " current " + sprite.currentAnim);
		graphic = sprite;
				
		
	}
	public function addAnimations(anims:Map < String, Array<Int> > , ?rate:Int=10)
	{
		for (name in anims.keys()) {
			sprite.add(name, anims[name], rate);
		}
	}
	
	public function addAnimation(name:String, frames:Array<Int>, ?rate:Int = 10)
	{
		//HAX
		var loop = true;
		if (name == "jump") loop = false;
		
		sprite.add(name, frames, rate, loop);
	}
	
	public override function update() 
	{
		super.update();
		
		if (null != inputCallback) {
				inputCallback(this);
		}		
	}
	public var inputCallback:TmxAnimatedObject->Void;
	
	public var sprite:Spritemap;
	//public var name:String; //apparently exists by default?
}