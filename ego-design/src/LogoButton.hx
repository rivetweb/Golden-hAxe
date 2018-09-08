import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

import egodesign.Utils;

class LogoButton extends SimpleButton {

	public function new()	{
		super();
		addEventListener(MouseEvent.CLICK, item_click);
	}
	
	function item_click(e:MouseEvent) {
		Main.sound_click1.play();
		Main.submenu.hide();
		Utils.resetCurrentGroup();
		
		Lib.current.gotoAndPlay(1, "main_page");
	}
}