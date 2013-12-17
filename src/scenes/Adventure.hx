package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxMap;
import entities.CompositeCreature;
import entities.Creature;

/**
 * ...
 * @author Esa Karjalainen
 */
class Adventure extends MapScene
{

	public static var levels:Array<String> = [
		"testventure.tmx",
		"scrolltest.tmx",
		"battle.tmx",
		"title.tmx"
	];
	public function new(?mapname:String="testventure.tmx") 
	{
		super();
		//trace(mapname);
		
		map = TmxMap.loadFromFile(Std.string("maps/" + mapname));						
		//map = TmxMap.loadFromFile(Std.string("maps/testventure.tmx"));						
		
		// The following thing is hacky on haxepunk/tiled's part, but it un-breaks missing tileset, it seems.
		if (mapname == "battle.tmx") {
			drawMap(map, [
				"smalltiles16x30.png" => ["Tiles"]
				]);

		} else {		
			drawMap(map, [
				"testventure.png" => ["Tiles"]
				]);
		}
	}
	
	override public function begin() 
	{
		super.begin();
		
		var creatures = new Array<CompositeCreature>();
		
		getType("creature", creatures);
		for (c in creatures) {
			c.allowVerticalMovement = false;
				
			//trace(c.name);
			if (c.name == "Player") {
				c.userInput = true;
			}
		}
	}
	
	
	private var testmove = -1;
	override public function update() 
	{
		super.update();
		var creatures = new Array<CompositeCreature>();
		
		getType("creature", creatures);
		for (c in creatures) {
			c.allowVerticalMovement = false;
				
			if (c.name == "Player") {
				c.userInput = true;
				var cam_d = c.x + c.halfWidth - camera.x; // delta
				var from_center = Math.abs(cam_d - HXP.screen.width / 2);
				var magic = 5;
				
				// Dead zone not needed.
				if (cam_d < HXP.screen.width / 2) {
					if (camera.x > 0) {
					camera.x -= (from_center/magic);
					
					}
					
				} else if (cam_d > HXP.screen.width / 2){
					camera.x += (from_center/magic);
				}	
				
			} else if (c.name == "spider") {		
				if (null == c.inputHandler) {
					c.inputHandler = new CreatureInput();
				}
				//trace(c.inputHandler);
				if (c.children.length == 0) {
					testmove = 0;
				}
				c.inputHandler.setInput( testmove, 0);
				if (c.x < 30) testmove = 1;
				if (c.x > 200) testmove = -1;				
			
			} else {
				
			}
			
		}
		
		if (!map.objectGroups.exists("Areas")) return;
		for (area in map.getObjectGroup("Areas").objects) {			
			var entity = collideRect("creature", area.x, area.y, area.width, area.height);
			
			//var entity = collideRect("creature", 0, 0, 400, 240);
			//trace([area.x, area.y, area.width, area.height]);
			if (null != entity) {
				
				var creature:Creature = cast entity;
								
				if (area.name == "pit" && !creature.inputHandler.jumping) {
					creature.inputHandler.setVelocity(0);
					entity.moveBy(0, creature.width/8);					
					if (entity.y > area.y) {
						//trace(entity.name);
						if (entity.name == "Player") {
							HXP.scene = new Menu();
							HXP.swapScene();
						} 
						remove(entity);						
					}
				}
				
				if (area.type == "portal") {
					var level = area.custom.resolve("Load");
					//trace(level);
					HXP.scene = new Adventure(level);
					HXP.swapScene();
					camera.setTo(0, 0);
				}
				if (area.type == "walkable") {
					creature.allowVerticalMovement = true;
				}
			}
		}
		
	}
	private var map:TmxMap;
	
}