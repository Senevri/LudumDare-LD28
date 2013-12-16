package ;
import scenes.*;
 
import com.haxepunk.Engine;
import com.haxepunk.HXP;
 
class Main extends Engine {    
    override public function init() {
        super.init();
#if debug
        HXP.console.enable();
#end
        trace("HaxePunk is running!");
		HXP.scene = new Menu();
		HXP.screen.scale = 2;
		
    }
	
	
    public static function main() { new Main(); }
}