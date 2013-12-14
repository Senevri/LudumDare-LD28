package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
//import com.haxepunk.utils.Input;
//import com.haxepunk.utils.Key;


/**
 * ...
 * @author Esa Karjalainen
 */
class Creature extends TmxAnimatedObject
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		this.collidable = true;
		this.type = "creature";
	}
	
	override public function update() 
	{
		super.update();
		
		//trace("update");
		if (null != inputHandler) {
			var input:Map<String, Float> = inputHandler.getInput(this);
		}
	}	
	public var currentPosition:Int = 0;
	public var inputHandler:CreatureInput = null;	
}