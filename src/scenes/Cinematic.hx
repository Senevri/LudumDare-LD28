package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.media.Sound;
import openfl.Assets;

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
	
	public function setAudio(source:Dynamic) {
		var asset = Asset.music(Std.string(source));
		var sfx = new Sfx(asset);
		trace(sfx);
		audio = sfx;
	}
	
	public override function begin() 
	{
		
		
	}
	
	public override function update() 
	{
		super.update();
		animation.play("default");
		if (null != audio && !audio.playing) {
			audio.play();
		}
		
		if (Input.check("done")) {
			HXP.scene = new Menu();
			HXP.swapScene();
		}
	}
	
	private var framesource:Dynamic;
	private var animation:Spritemap;
	private var audio: Sfx = null;
}