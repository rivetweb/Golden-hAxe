package ;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.text.TextField;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;

class BreadcrumbItem extends MovieClip {

	public function new() {
		super();
		addEventListener(MouseEvent.CLICK, mouse_click);
	}
	
	function mouse_click(e:MouseEvent) {
		Main.sound_click1.play();
		
		if (this.toString().indexOf("brcr_main") >= 0)
			Lib.current.gotoAndPlay(1, "main_page");
		else if (this.toString().indexOf("brcr_project") >= 0) {
			Main.current_project = -1;
			Lib.current.gotoAndPlay(1, "projects");
		}
	}
	
}