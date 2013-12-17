package ;

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
	
	static private function pathify(string:String, imgpath:String):String
	{
		//trace(imgpath);
		if ( -1 == imgpath.indexOf("/")) {
			imgpath = Std.string("/" + imgpath);
		}
		return Std.string(string + imgpath.substr(imgpath.lastIndexOf("/")));
	
	}
	
}