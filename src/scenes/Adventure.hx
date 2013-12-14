package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxMap;
import entities.Creature;

/**
 * ...
 * @author Esa Karjalainen
 */
class Adventure extends MapScene
{

	public static var levels:Array<String> = [
		"testventure.tmx"
	];
	public function new() 
	{
		super();
		map = TmxMap.loadFromFile("maps/testventure.tmx");						
		drawMap(map, [
			"testventure.png" => ["Tiles"]
			]);
		
	}
	
	override public function begin() 
	{
		super.begin();
	}
	
	override public function update() 
	{
		super.update();
		
		if (!map.objectGroups.exists("Areas")) return;
		for (area in map.getObjectGroup("Areas").objects) {			
			var entity = collideRect("creature", area.x, area.y, area.width, area.height);
			
			//var entity = collideRect("creature", 0, 0, 400, 240);
			//trace([area.x, area.y, area.width, area.height]);
			if (null != entity) {
				var creature:Creature = cast entity;
				if (area.name == "pit" && !creature.inputHandler.jumping) {
					entity.moveBy(0, 4);					
					if (entity.y > area.y) {
						//trace(entity.name);
						if (entity.name == "Player") {
							HXP.scene = new Menu();
							HXP.swapScene();
						} 
						remove(entity);						
					}
				}
			}
		}
		
	}
	private var map:TmxMap;
	
}