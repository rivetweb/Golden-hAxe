package ;

import flash.display.MorphShape;
import flash.display.Shape;
import flash.text.TextField;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.net.URLRequest;

class GroupButton extends MovieClip {
	public var label:TextField;
	
	public var bg:MovieClip;
	
	public function new() {
		super();
		
		buttonMode = true;
		useHandCursor = true;
		label = cast(getChildAt(2), TextField);
		mouseChildren = false;
		
		bg = cast(getChildAt(0), MovieClip);
		
		addEventListener(MouseEvent.CLICK, item_click);
		addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
		addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
	}
	
	function item_click(e:MouseEvent) {
		if (cast(e.currentTarget, MovieClip) == Main.submenu.items[Main.submenu.items.length - 1] &&
				Main.submenu.active_item != null)
			Main.submenu.remove_listener();
		
		Main.sound_click1.play();
		Main.submenu.set_active_item(cast(e.currentTarget, MovieClip));
	}
	
	function mouse_over(e:MouseEvent) {
		bg.gotoAndPlay(2);
	}
	
	function mouse_out(e:MouseEvent) {
		bg.gotoAndPlay(1);
	}
}