package ;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Creature;
import entities.Bullet;	

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
		if (!creature.userInput) {
			return ["message" => -1];
		}
		var vmult = creature.width / 16;
		//trace ("getting input " + creature.x + " | " + creature.currentPosition*creature.width);
		//prevent leaving map
		if (creature.sprite.complete) {			
			jumping = false;
			if (creature.sprite.currentAnim != "walk") 
				creature.sprite.play("idle");
		}
		
		if (creature.sprite.currentAnim == "idle") { h_velocity = 0; }
		
		
		if (creature.x + h_velocity < 0 && h_velocity != 0) {
				h_velocity = 0;
				jumping = false;
				creature.currentPosition = 0;
		}
		
		if ((creature.currentPosition * creature.width) == creature.x) {
			jumping = false;
			h_velocity = 0;
			v_velocity = 0;
		}
		
		if (!jumping) {
			if (Input.check("left")) { 	
				if (h_velocity == 0) creature.currentPosition -= 1;
				h_velocity = -vmult;
			}
			if (Input.check("right")) { 	
				if (h_velocity == 0) creature.currentPosition += 1;
				h_velocity = vmult;
			}
			
			if (creature.allowVerticalMovement) {
				//trace(creature.currentArea);
				if (Input.check("up")) { 	
					v_velocity = -vmult;
				}
				if (Input.check("down")) { 	
					v_velocity = vmult;
				}
			} else {
				v_velocity = 0;
			}
		}
		
		if (h_velocity<0) {
			creature.sprite.flipped = true;
			
		} else {
			creature.sprite.flipped = false;
			
		}
				
		if (Input.check("attack")) {
			creature.sprite.play("attack");					
			if (creature.ammo > 0) {
				var bullet:Bullet = new Bullet(creature.x + creature.width, creature.y);
				bullet.velocity = 3;
				bullet.angle = 80 - this.h_velocity*5;
				HXP.scene.add(bullet);
				creature.ammo -= 1;
			}
			
		} else if (Input.check("jump") && !jumping) {
			jumping = true;
			var anim = creature.sprite.play("jump");			
			h_velocity = facing/Math.abs(facing) * 2*vmult;	
			//trace ("getting input " + creature.x + " | " + creature.currentPosition*creature.width);
		
			creature.currentPosition += 2*Math.round((h_velocity / Math.abs(h_velocity)));
		} else if (!jumping) {		
			if (0 == h_velocity && 0 == v_velocity) {
				creature.sprite.play("idle");
			} else {		
				creature.sprite.play("walk");			
			}
		}
		
		creature.moveBy(h_velocity, v_velocity);
			
		// keep track of last direction moved
		if (h_velocity != 0 && !jumping) {
			facing = h_velocity;
		}
		return ["x" => h_velocity, "y"=>v_velocity];
		
		
	}
	
	public function setVelocity(object:Float) 
	{
		h_velocity = object;
	}
	
	private var facing:Float = 2;
	private var h_velocity:Float = 0;
	private var v_velocity:Float = 0;
	public var jumping:Bool = false;	
}