package ;
import flash.media.Sound;
import openfl.Assets;

/**
 * ...
 * @author Esa Karjalainen
 */
class Asset
{

	public function new() 
	{
		

	}
	
	public static function graphics(imgpath:String):String
	{
		return pathify("gfx", imgpath);
	}
	
	static public function sfx(string:String):String 
	{
		return pathify("sfx", string);
	}
	
	static public function music(source:String):Dynamic 
	{
		var music = pathify("music", source);
		//var music = Assets.getMusic(source);
		return music;
	}
	
	static private function pathify(string:String, imgpath:String):String
	{
		//trace(imgpath);
		if ( -1 == imgpath.indexOf("/")) {
			imgpath = Std.string("/" + imgpath);
		}
		return Std.string(string + imgpath.substr(imgpath.lastIndexOf("/")));
	
	}
	
}