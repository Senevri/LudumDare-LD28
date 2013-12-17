package entities;

import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.masks.Imagemask;
//import entities.CompositeCreature.SlaveInput;
import entities.Creature;

/**
 * ...
 * @author Esa Karjalainen
 */
class CompositeCreature extends Creature
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		this.children = new Array<Creature>();
		this.name = "unknown";
	}
	
	public function addChild(child:Creature) {
		children.push(child);
	}	
	
	override public function update() 
	{
		var old_position = {x: this.x, y: this.y} ;		
		super.update();
		//trace(old_position, this.x, this.y);
		
		//trace(children.length);
		for (child in this.children) {
			child.inputHandler.setInput(this.x - old_position.x, this.y - old_position.y);
		}
	}
	
	public var children:Array<Creature>;
}

/*
class SlaveInput extends CreatureInput
{
	public function new(master:CompositeCreature)
	{
		this.master = master;
	}
	
	override public function getInput(creature:Creature):Map<String, Float> 
	{
		//return super.getInput(master);
		//AI move here
		//master.getMotion();
	}
	
	public var master:CompositeCreature;
}*/