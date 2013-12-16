package scenes;

import com.haxepunk.Scene;
import entities.Bullet;

/**
 * ...
 * @author Esa Karjalainen
 */
class Test extends Scene
{

	public function new() 
	{
		super();
		
	}
	
	public override function begin() 
	{
		add(new Bullet(30, 30));
	}
	
}