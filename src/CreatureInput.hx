package ;

import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Creature;

/**
 * ...
 * @author Esa Karjalainen
 */
class CreatureInput
{

	public function new() 
	{
		//todo different reactions to types
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("enter", [Key.ENTER]);
		Input.define("space", [Key.SPACE]);
	}
	
	public function getInput(creature:Creature):Map<String, Float>
	{
		
		trace ("getting input " + creature.x + " | " + creature.currentPosition*creature.width);
		if ((creature.currentPosition*creature.width) == creature.x) 
			velocity = 0;
		
		
		if (Input.check("left")) { 	
			if (velocity == 0) creature.currentPosition -= 1;
			velocity = -2;
		}
		if (Input.check("right")) { 	
			if (velocity == 0) creature.currentPosition += 1;
			velocity = 2;
		}
		
		if (0 == velocity) {
			creature.sprite.play("idle");
		} else {		
			creature.sprite.play("walk");			
		}
		
		
		if (velocity<0) {
			creature.sprite.flipped = true;
			
		} else {
			creature.sprite.flipped = false;
			
		}	
			creature.moveBy(velocity, 0);
		
		return ["x"=>velocity];
	}
	private var velocity:Float=0;
	
}