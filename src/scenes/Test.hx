package scenes;

import com.haxepunk.Scene;
import entities.TestEntity;

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
		add(new TestEntity(30, 30));
	}
	
}