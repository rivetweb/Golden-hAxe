package ;

import flash.display.MorphShape;
import flash.display.Shape;
import flash.text.TextField;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.net.URLRequest;

import egodesign.Utils;

class ProjectButton extends MovieClip {

	public function new() {
		super();
		mouseChildren = false;
		buttonMode = true;
		addEventListener(MouseEvent.CLICK, item_click);
		addEventListener(MouseEvent.ROLL_OVER, mouse_over);
		addEventListener(MouseEvent.ROLL_OUT, mouse_out);
	}
	
	function item_click(e:MouseEvent) {
		Main.sound_click1.play();
		Main.submenu.hide();
		Utils.resetCurrentGroup();
		
		var s = e.currentTarget.toString();
		Main.current_group = 0;
		if (s.indexOf("live_interior") >= 0)
			Main.current_group = 0;
		else if (s.indexOf("publ_interior") >= 0)
			Main.current_group = 1;
		else if (s.indexOf("other") >= 0)
			Main.current_group = 2;
		Lib.current.gotoAndPlay(1, "projects");
	}
	
	function mouse_over(e:MouseEvent) {
		gotoAndPlay(2);
	}
	
	function mouse_out(e:MouseEvent) {
		gotoAndPlay(1);
	}
}