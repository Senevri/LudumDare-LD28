package scenes;

import com.haxepunk.Scene;
import com.haxepunk.tmx.TmxMap;

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
	}
	private var map:TmxMap;
	
}