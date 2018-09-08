package ;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

class SerialButton extends SimpleButton {
	public function new() {
		super();
		
		addEventListener(
			MouseEvent.CLICK,
			function (e:MouseEvent) {
				switch(e.target.name) {
					case "bser1_1_1":
						Lib.current.gotoAndPlay(1, "tea");
					case "bser1_1_2":
						Lib.current.gotoAndPlay(1, "pack");
						
					case "bser1_2_1":
						Lib.current.gotoAndPlay(5, "tea");
					case "bser1_2_2":
						Lib.current.gotoAndPlay(5, "pack");
						
					case "bser1_3_1":
						Lib.current.gotoAndPlay(9, "tea");
					case "bser1_3_2":
						Lib.current.gotoAndPlay(9, "pack");
					
					case "bser1_4_1":
						Lib.current.gotoAndPlay(13, "tea");
					case "bser1_4_2":
						Lib.current.gotoAndPlay(13, "pack");
					
					
					
					case "bser2_1_1":
						Lib.current.gotoAndPlay(17, "tea");
					case "bser2_1_2":
						Lib.current.gotoAndPlay(17, "pack");
					
					case "bser2_2_1":
						Lib.current.gotoAndPlay(21, "tea");
					case "bser2_2_2":
						Lib.current.gotoAndPlay(21, "pack");
					
					case "bser2_3_1":
						Lib.current.gotoAndPlay(25, "tea");
					case "bser2_3_2":
						Lib.current.gotoAndPlay(25, "pack");
					
					
					
					
					case "bser3_1_1":
						Lib.current.gotoAndPlay(29, "tea");
					case "bser3_1_2":
						Lib.current.gotoAndPlay(29, "pack");
					
					case "bser3_2_1":
						Lib.current.gotoAndPlay(33, "tea");
					case "bser3_2_2":
						Lib.current.gotoAndPlay(33, "pack");
					
					case "bser3_3_1":
						Lib.current.gotoAndPlay(37, "tea");
					case "bser3_3_2":
						Lib.current.gotoAndPlay(37, "pack");
				}
			});
	}
	
}