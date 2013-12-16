package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;

/**
 * ...
 * @author Esa Karjalainen
 */
class TmxArea extends Entity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		this.properties = new Map();
		super(x, y, graphic, mask);
		this.setHitbox(this.width, this.height);		
		this.collidable = true;
		this.type = "area";
	}	
	public var properties:Map<String, String>;
}