package ;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

class BackButton extends SimpleButton {
	public function new() {
		super();
		
		addEventListener(
			MouseEvent.CLICK,
			function (e:MouseEvent) {
				var s:String = e.target.name;
				if (s.indexOf("bbser1_1") == 0)
					Lib.current.gotoAndPlay(1, "serie");
				else if (s.indexOf("bbser1_2") == 0)
					Lib.current.gotoAndPlay(6, "serie");
				else if (s.indexOf("bbser1_3") == 0)
					Lib.current.gotoAndPlay(11, "serie");
				else if (s.indexOf("bbser1_4") == 0)
					Lib.current.gotoAndPlay(16, "serie");
				
				else if (s.indexOf("bbser2_1") == 0)
					Lib.current.gotoAndPlay(21, "serie");
				else if (s.indexOf("bbser2_2") == 0)
					Lib.current.gotoAndPlay(26, "serie");
				else if (s.indexOf("bbser2_3") == 0)
					Lib.current.gotoAndPlay(31, "serie");
				
				else if (s.indexOf("bbser3_1") == 0)
					Lib.current.gotoAndPlay(36, "serie");
				else if (s.indexOf("bbser3_2") == 0)
					Lib.current.gotoAndPlay(41, "serie");
				else if (s.indexOf("bbser3_3") == 0)
					Lib.current.gotoAndPlay(46, "serie");
				
			});
	}
	
}