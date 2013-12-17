package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * ...
 * @author Esa Karjalainen
 */
class Cinematic extends Scene
{

	
	public function new(framesource:Dynamic, width:Int, height:Int, frames:Int, ?fps:Float=10 ) 
	{
		super();
		this.framesource = framesource;
		var sprite = new Spritemap(Asset.graphics(Std.string(framesource + ".png")), width, height);
		sprite.add("default", [for (i in 0...frames) i], fps, false);
		var e = addGraphic(sprite);
		animation = sprite;
		Input.define("done", [Key.ANY]);
		
		
	}
	
	public override function begin() 
	{
		
		
	}
	
	public override function update() 
	{
		super.update();
		animation.play("default");
		if (Input.check("done")) {
			HXP.scene = new Menu();
			HXP.swapScene();
		}
	}
	
	private var framesource:Dynamic;
	private var animation:Spritemap;
}