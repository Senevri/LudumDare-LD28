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
		]);
		HXP.scene = new Test();
		
		HXP.swapScene();		
		
	}
	
	public override function update() {
		super.update();
	}
}