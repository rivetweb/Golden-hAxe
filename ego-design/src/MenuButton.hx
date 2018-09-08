package ;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

import egodesign.Utils;

class MenuButton extends SimpleButton {
	var default_state:DisplayObject;
	
	public function new() {
		super();
		default_state = upState;
		
		addEventListener(MouseEvent.CLICK, item_click);
	}
	
	function item_click(e:MouseEvent) {
		Main.sound_click1.play();
		Main.submenu.hide();
		Utils.resetCurrentGroup();

		var s:String = e.target.name;
		switch(s) {
			case "bmain_about_us":
				Lib.current.gotoAndPlay(1, "about us");
				
			case "bmain_services":
				Lib.current.gotoAndPlay(1, "services");
				
			case "bmain_projects":
				Main.btn_projects = cast(e.target, MenuButton);
				Main.submenu.show(cast(e.target, SimpleButton));

			case "bmain_contacts":
				Lib.current.gotoAndPlay(1, "contacts");
		}
	}
	
	public function set_active_state() {
		upState = overState;
	}
	
	public function set_default_state() {
		upState = default_state;
	}
}