package controls;

import flash.display.MovieClip;
import flash.geom.Rectangle;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

class Scrollbar {

	// content view
	private var content:MovieClip;
	
	// box for content
	private var area:MovieClip;
	
	// scrollbar button
	private var scroller:MovieClip;
	
	// scrollbar line
	private var scrollable_area:MovieClip;
	
	private var sd:Float;
	private var sr:Float;
	private var cd:Float;
	private var cr:Float;
	private var new_y:Float;
	private var drag_area:Rectangle;
	
	private var scrollSpeed:Float; // 0.00 to 1.00
	private var scrollVelocity:Float;

	public function new(content:MovieClip, area:MovieClip, scroller:MovieClip, scrollable_area:MovieClip) {
		this.content = content;
		this.area = area;
		this.scroller = scroller;
		this.scrollable_area = scrollable_area;
		
		this.content.mask = this.area;
		//this.content.x = this.area.x;
		//this.content.y = this.area.y;
		
		scrollSpeed = 0.5;
		scrollVelocity = 3;
		
		onContentChange(content);
		
		scroller.addEventListener(MouseEvent.MOUSE_DOWN, scroller_drag);
		scroller.addEventListener(MouseEvent.MOUSE_UP, scroller_drop);
		
		Lib.current.addEventListener(Event.ENTER_FRAME, on_scroll);
		Lib.current.addEventListener(MouseEvent.MOUSE_WHEEL, scrollerWheel);
	}
	
	public function onContentChange(content:MovieClip) {
		sr = this.area.height / this.content.height;
		sd = this.scrollable_area.height - this.scroller.height;
		cd = this.content.height - this.area.height;
		cr = cd / sd;
		
		drag_area = new Rectangle(0, 0, 0, this.scrollable_area.height - this.scroller.height + 2);

		if (this.content.height <= this.area.height) {
			scroller.visible = scrollable_area.visible = false;
		}
		else {
			scroller.visible = scrollable_area.visible = true;
		}
	}
	
	public function setWheelVelocity(k:Float) {
		scrollVelocity = k;
	}
	
	public function setScrollSpeed(speed:Float) {
		if (scrollSpeed < 0 || scrollSpeed > 1 ) {
			scrollSpeed = 0.50;
		}
		else {
			scrollSpeed = speed;
		}
	}
	
	private function scroller_drag(me:MouseEvent) {
		var stage = flash.Lib.current.stage;
		
		me.target.startDrag(false, drag_area);
		stage.addEventListener(MouseEvent.MOUSE_UP, up);
	}

	private function scroller_drop(me:MouseEvent ) {
		var stage = flash.Lib.current.stage;
		me.target.stopDrag();
		stage.removeEventListener(MouseEvent.MOUSE_UP, up);
	}
	
	private function up(me:MouseEvent) {
		scroller.stopDrag();
	}
	
	private function scrollerWheel(m:MouseEvent) {
		if (!scroller.visible) {
			return;
		}
		
		var y = scroller.y;
		
		y = scroller.y - scrollVelocity * m.delta;
		
		//trace(scrollVelocity * m.delta);
		
		if (y < 0) {
			y = 0;
		}
		else if (y > scrollable_area.height - scroller.height) {
			y = scrollable_area.height - scroller.height;
		}
		
		scroller.y = y;
	}
	
	private function on_scroll(e:Event) {
		new_y = area.y + scrollable_area.y * cr - scroller.y  * cr;
		content.y += ( new_y - content.y ) * scrollSpeed;
	}
}



