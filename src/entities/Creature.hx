package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.masks.Imagemask;
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
		this.mask = new Imagemask(this.sprite);
		super.update();
		
		//trace("update");
		if (null != inputHandler) {
			var input:Map<String, Float> = inputHandler.getInput(this);
		}
	}	
	
	/*
	public override function moveCollideY(e:Entity)
    {
		trace(e);
		if (e.type=="bullet" && this.name != "Player") {
			scene.remove(e);
			scene.remove(this);
			return true;
		}
		return false;
    }*/
	
	public var allowVerticalMovement=false;
	public var currentPosition:Int = 0;
	public var inputHandler:CreatureInput = null;	
	public var currentArea:String = null;
	public var userInput = false;
	public var health:Float = 2;
	public var ammo:Int = 1; // for testing
}