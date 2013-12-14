package scenes;

import com.haxepunk.Scene;
import com.haxepunk.tmx.*;
import entities.TmxAnimatedObject;
#if nme
import nme.Assets;
#else
import openfl.Assets;
#end
import com.haxepunk.graphics.TiledImage;
import com.haxepunk.HXP;

import com.haxepunk.graphics.Image;


/**
 * ...
 * @author Esa Karjalainen
 */
class MapScene extends Scene
{

	public function new() 
	{
		super();
		
	}
	
	public function drawMap (map:TmxMap, layermap:Map < String, Array<String> > ) 
	{
		for (key in map.imageLayers.keys()) {
			var imgpath = map.imageLayers[key];
			addGraphic(new Image(Asset.graphics(imgpath)));			
		}
		
		// FIXME: cannot just arbitrarily load all graphics. As a hack I could do a hashmap for now, or match tileset name to layer.
		// Limits to 1 tileset per layer but that's okay. 
		var tileset_layer_map = layermap;
		
		var e = new TmxEntity(map);
		
		for (key in tileset_layer_map.keys()) {
				e.loadGraphic(Std.string("gfx/" + key), tileset_layer_map[key]);
			}
	
		/*for (tileset in map.tilesets) {
			for (layer in map.layers) {
				//trace(layer.name);
				//trace(Asset.graphics(tileset.imageSource));
					e.loadGraphic(Asset.graphics(tileset.imageSource), [layer.name]);
			}
		}*/
				
		add(e);
		
		for (group in map.objectGroups) 
		{
			//trace("group name:´" + group.name);
			if (null != group.properties.resolve("draw")) 
			{
				var tileset:TmxTileSet = null;
				
				for (object in group.objects)
				{
					//trace("object");
					if (object.gid > 0) {
						// find tileset
						for (ts in map.tilesets) 
						{							
							//trace("tilesets");
							ts.set_image(Assets.getBitmapData(Asset.graphics(ts.imageSource)));
							if (ts.hasGid(object.gid)) {
								//trace("tileset " + ts.name +" has gid " + object.gid + " first " + ts.firstGID + " count " +ts.numTiles); 
								tileset = ts;
								break;
							}
						} 
						if (null != tileset) 
						{							
							// FIXME fromgid doesn't work as expected.
							var index = tileset.fromGid(object.gid);
							//var index = object.gid - tileset.firstGID;
							
							//trace("tileset " + tileset.numCols + " - " + tileset.numRows);							
							//trace(Asset.graphics(tileset.imageSource) + " w " + tileset.tileWidth + " h " + tileset.tileHeight);
							//trace("looking for rect " + index + " rect " + tileset.getRect(index).toString());
							
							//trace("frames value: " + object.custom.resolve("frames"));
							if (object.custom.resolve("frames") == null) { 															
								addGraphic(
									new TiledImage(
										Asset.graphics(tileset.imageSource), 
										tileset.tileWidth, 
										tileset.tileHeight, 
										tileset.getRect(index)
									), 
									HXP.BASELAYER, object.x, object.y-tileset.tileHeight
								);			
							} else {								
								var framecount = Std.parseInt(object.custom.resolve("frames"));
								var name = object.custom.resolve("name");
								if (name == null) name = "undefined"; 
								if (framecount == null) {
									framecount = 1;
								}
								var e = new TmxAnimatedObject(object.x, object.y - tileset.tileHeight);
								//trace("added object");
								e.addSprites(tileset.imageSource, tileset.tileWidth, tileset.tileHeight, 
										tileset.fromGid(object.gid), framecount); 
								e.name = name;
								add(e);
								////trace(object.custom.frames);
							}
						} 						
					}
				}
			}
		}
	}		
	
}