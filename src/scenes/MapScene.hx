package scenes;

import com.haxepunk.graphics.prototype.Rect;
import com.haxepunk.Scene;
import com.haxepunk.tmx.*;
import entities.Creature;
import entities.TmxAnimatedObject;
import entities.TmxArea;
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
		viewport = new Rect(HXP.screen.width, HXP.screen.height);
		viewport.x = 0;
		viewport.y = 0;
		HXP.setCamera(0, 0);
		//for now we only care about X and Y offsets.
	}
	
	public var viewport:Rect;
	
	public function drawMap (map:TmxMap, layermap:Map < String, Array<String> >, ?inputHandler:TmxAnimatedObject->Void=null ) 
	{
		for (key in map.imageLayers.keys()) {
			var imgpath = map.imageLayers[key];
			//trace("aa" + imgpath);
			addGraphic(new Image(Asset.graphics(imgpath)));			
		}
		
		// FIXME: cannot just arbitrarily load all graphics. As a hack I could do a hashmap for now, or match tileset name to layer.
		// Limits to 1 tileset per layer but that's okay. 
		var tileset_layer_map = layermap;
		
		var e = new TmxEntity(map);
		e.followCamera = true;
		
		
		for (key in tileset_layer_map.keys()) {
				//trace(key + ", " + tileset_layer_map[key]);
				e.loadGraphic(key, tileset_layer_map[key]);
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
			var draw:String = group.properties.resolve("draw");
			if (null != draw && draw == "yes") 
			{
				var tileset:TmxTileSet = null;
				
				for (object in group.objects)
				{
					//trace(object);
					if (object.gid > 0) {
						// find tileset
						for (ts in map.tilesets) 
						{							
							//trace("tilesets");
							//trace("bb" + ts.imageSource);
							if (ts.imageSource == null) {
								break;
							}
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
							if (object.custom.resolve("frames") == null) { // add static
								//trace("cc" + object.name);
								addGraphic(
									new TiledImage(
										Asset.graphics(tileset.imageSource), 
										tileset.tileWidth, 
										tileset.tileHeight, 
										tileset.getRect(index)
									), 
									HXP.BASELAYER, object.x, object.y-tileset.tileHeight
								);			
							} else { // add animated
								var framecount = Std.parseInt(object.custom.resolve("frames"));
								var name = object.name;
								if (name == null) name = "undefined"; 
								if (framecount == null) {
									framecount = 1;
								}
								
								if (object.type == "creature") {
									//trace(object.custom);
									//creatures can have "animations" = "idle, walk", and "frames" is a list of ints
									var e = new Creature(object.x, object.y - tileset.tileHeight);
									e.name = name;
									e.width = tileset.tileWidth;
									e.height = tileset.tileHeight;
									e.currentPosition = Math.round(object.x / tileset.tileWidth);
							
									//trace("creature: " +e.name);
									var health = object.custom.resolve("health");
									if (null == health) health = "2";
									
									e.health = Std.parseFloat(health);
									
									var animations = object.custom.resolve("animations"); 
									//trace(animations);
									var frames = object.custom.resolve("frames");
									//trace(frames);
									var first:Bool = true;
									if (null != animations) {
										// split on comma, trim
										var framecounts:Array<Int> = Lambda.array(
											Lambda.map(
													Std.string(frames).split(", "), function(v):Int { return Std.parseInt(v);  } 
												)
										);
										var currentframe = 0;
										var index = 0;									
										for (anim in Std.string(animations).split(", ")) {
											//trace(anim);
											if (first) {
												e.addSprites(tileset.imageSource, tileset.tileWidth, tileset.tileHeight,
														tileset.fromGid(object.gid), framecounts[0], name = anim);											
												first = false;
												currentframe += framecounts[index];
												index = 1;												
											} else {
												var range = [for (i  in currentframe...(currentframe + framecounts[index])) i];
												//trace(range);
												e.addAnimation(anim, range);
												currentframe += framecounts[index];
											}
											
										}
									}
									//trace("adding inputhandler");
									e.inputHandler = new CreatureInput();											
									// could add scene to inputhandler.
									add(e);								
								} else {
									var e = new TmxAnimatedObject(object.x, object.y - tileset.tileHeight);
									//trace("added object");
									e.addSprites(tileset.imageSource, tileset.tileWidth, tileset.tileHeight, 
											tileset.fromGid(object.gid), framecount); 
									e.name = name;
									e.inputCallback = inputHandler;
									add(e);
								}
								////trace(object.custom.frames);
							}
						} 						
					}
				}
			} else { // not drawable object group
				if (group.name == "Areas") {
					for (object in group.objects) {
						var e = new TmxArea(object.x, object.y);
						e.width = object.width;
						e.height = object.height;						
						e.name = object.name;
						//e.parameters = object.custom.parameters();
						e.properties.set("direction", object.custom.resolve("direction"));
						
						add(e);
					}
					
				}
			}
		}
	}		
	
}