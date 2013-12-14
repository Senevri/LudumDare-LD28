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
		Input.define("jump", [Key.SPACE]);
		Input.define("attack", [Key.X]);
		
	}
	
	public function getInput(creature:Creature):Map<String, Float>
	{
		if (jumping) {
			/*if (creature.x != creature.currentPosition * creature.width) {
					creature.sprite.setAnimFrame("jump", 3);
			}*/
			if (Math.round(creature.x+velocity / creature.width) < 0) {
				velocity = 0;
			}
			
			if ((creature.currentPosition * creature.width) != creature.x+velocity) {				
				creature.moveBy(velocity*2, 0);
				//return null; //not used as of yet
			} else {
				velocity = 0;
			}
			if (creature.sprite.complete) {
				creature.currentPosition = Math.round(creature.x / creature.width);
				jumping = false;
				velocity = 0;
				creature.sprite.play("idle");
			} else {
				return null;
			}
		}
		
		//trace ("getting input " + creature.x + " | " + creature.currentPosition*creature.width);
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
		
		if (Input.check("attack")) {
			creature.sprite.play("attack");
		}  else if (Input.check("jump")) {
			jumping = true;
			var anim = creature.sprite.play("jump");			
			velocity = facing;
			
		} else {		
			if (0 == velocity) {
				creature.sprite.play("idle");
			} else {		
				creature.sprite.play("walk");			
			}
		}
		
		
		if (velocity<0) {
			creature.sprite.flipped = true;
			
		} else {
			creature.sprite.flipped = false;
			
		}	
		creature.moveBy(velocity, 0);
			
		// keep track of last direction moved
		if (velocity != 0) {
			facing = velocity;
		}
		return ["x"=>velocity];
	}
	
	private var facing:Float = 2;
	private var velocity:Float = 0;
	public var jumping:Bool = false;
}