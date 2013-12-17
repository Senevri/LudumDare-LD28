package ;
import com.haxepunk.RenderMode;
import scenes.*;
 
import com.haxepunk.Engine;
import com.haxepunk.HXP;
 
class Main extends Engine {    
	
	
#if cpp
	public function new() {		
		super(0, 0, 60, false, RenderMode.BUFFER);
	}
#end	
    override public function init() {
        super.init();
#if debug
        HXP.console.enable();
#end
        //trace("HaxePunk is running!");
		HXP.scene = new Menu();
		HXP.screen.scaleY = HXP.screen.height / internalRez.y;
		HXP.screen.scaleX = HXP.screen.width / internalRez.x;		
		
    }
	
	
    public static function main() { new Main(); }
	
	private static var internalRez = {x:400, y:240}
}