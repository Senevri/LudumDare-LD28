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
		//trace(imgpath);
		if ( -1 == imgpath.indexOf("/")) {
			imgpath = Std.string("/" + imgpath);
		}
		return Std.string("gfx" + imgpath.substr(imgpath.lastIndexOf("/")));
	}
	
}