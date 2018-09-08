package ;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.text.TextField;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;

class Subitems extends MovieClip {

	public var bgroup:MovieClip;
	public var label:TextField;
	public var items:MovieClip;
	public var box:Shape;
	public var bg:MovieClip;
	
	public var group_index:Int;
	
	public function new() {
		super();
		
		group_index = -1;
		
		buttonMode = true;
		useHandCursor = true;
		
		bgroup = cast(getChildAt(1), MovieClip);
		bgroup.addEventListener(MouseEvent.CLICK,  item_click);
		bgroup.mouseChildren = false;
		
		label = cast(bgroup.getChildAt(1), TextField);
		items	= cast(getChildAt(0), MovieClip);
		box = cast(items.getChildAt(0), Shape);
		
		var m:MovieClip = cast(items.getChildAt(1), MovieClip);
		m.visible = false;
		
		bg = cast(bgroup.getChildAt(0), MovieClip);
		bgroup.addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
		bgroup.addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
	}
	
	public function item_click(e:MouseEvent) {
		Main.sound_click1.play();
		
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		Main.current_group = group_index;
		Main.submenu.hide();
		Lib.current.gotoAndPlay(1, "projects");
	}
	
	function mouse_over(e:MouseEvent) {
		bg.gotoAndPlay(2);
	}
	
	function mouse_out(e:MouseEvent) {
		bg.gotoAndPlay(1);
	}
}