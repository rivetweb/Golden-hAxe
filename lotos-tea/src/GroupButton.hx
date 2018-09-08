package ;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

class GroupButton extends SimpleButton {
	public function new() {
		super();
		
		addEventListener(
			MouseEvent.CLICK,
			function (e:MouseEvent) {
				switch(e.target.name) {
					case "b3_vkus1":
						Lib.current.gotoAndPlay(1, "serie");
					case "b3_ang1":
						Lib.current.gotoAndPlay(6, "serie");
					case "b3_arom1":
						Lib.current.gotoAndPlay(16, "serie");
					case "b3_ch1":
						Lib.current.gotoAndPlay(11, "serie");
						
					case "b1_modern1":
						Lib.current.gotoAndPlay(21, "serie");
					case "b1_lv1":
						Lib.current.gotoAndPlay(26, "serie");
					case "b1_clas1":
						Lib.current.gotoAndPlay(31, "serie");
					
					case "b2_cart1":
						Lib.current.gotoAndPlay(36, "serie");
					case "b2_ves1":
						Lib.current.gotoAndPlay(41, "serie");
					case "b2_pak2":
						Lib.current.gotoAndPlay(46, "serie");
					
				}
			});
	}
	
}