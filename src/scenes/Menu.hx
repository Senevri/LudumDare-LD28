package scenes;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.Scene;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.tmx.TmxLayer;
import com.haxepunk.tmx.TmxObjectGroup;
import com.haxepunk.tmx.TmxObject;
import com.haxepunk.tmx.TmxTileSet;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import entities.TmxAnimatedObject;
import scenes.Adventure;

/**
 * ...
 * @author Esa Karjalainen
 */
class Menu extends MapScene
{
	private var map:TmxMap;
	public function new() 
	{
		super();
		
		map = TmxMap.loadFromFile("maps/title.tmx");						
		drawMap(map, [
			"tiles.png" => ["Options"], 
			//"title.png" => ["Graphical Objects"], 			
		], Menu.menuHandler);
		//HXP.scene = new Test();
		
		//HXP.swapScene();		
		
	}
	private static var velocity:Float = 0;
	
	public static function menuHandler(entity:TmxAnimatedObject) 
	{
		velocity = 0;
		
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("enter", [Key.ENTER]);
		
		if (Input.check("up")) { 	
			velocity = -8;
		}
		if (Input.check("down")) { 	
			velocity = 8;
		}
		
		
		
		var area = entity.collide("area", entity.x, entity.y+velocity+entity.height);
		if (null != area) {
			if (Input.check("up")) { 	
				entity.moveBy(0, velocity);
			}
			
			if (Input.check("down")) { 
				entity.moveBy(0, velocity);
			}
			
			if (Input.check("enter")) {							
				switch (area.name) {
					case "cinematic":
						var cinematic = new Cinematic("intro_movie", 400, 240, 20, 2);
						cinematic.setAudio("BoxCat_Games_-_11_-_Assignment.mp3");
						HXP.scene = cinematic;
						HXP.swapScene();
					case "enter":
						//trace("enter game");
						HXP.scene = new Adventure("battle.tmx");
						HXP.swapScene();
					default:
						trace(area.name);
				}
			
			}
		}
		
	}
	
	public override function update() {
		super.update();
	}
}