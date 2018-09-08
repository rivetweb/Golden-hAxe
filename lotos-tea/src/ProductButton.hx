package ;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;

class ProductButton extends SimpleButton {
	public function new() {
		super();
		
		addEventListener(
			MouseEvent.CLICK,
			function (e:MouseEvent) {
				switch(e.target.name) {
					case "product1_b_fr":
						Lib.current.gotoAndPlay(1, Main.scene_names[2]);
					case "product1_b_mr":
						Lib.current.gotoAndPlay(1, Main.scene_names[1]);
					
					case "product2_b_fs":
						Lib.current.gotoAndPlay(1, Main.scene_names[0]);
					case "product2_b_fr":
						Lib.current.gotoAndPlay(1, Main.scene_names[2]);
					
					case "product3_b_fs":
						Lib.current.gotoAndPlay(1, Main.scene_names[0]);
					case "product3_b_mr":
						Lib.current.gotoAndPlay(1, Main.scene_names[1]);
				}
			});
	}
	
}