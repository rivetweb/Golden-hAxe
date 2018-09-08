package egodesign.controls.gallery;

import flash.display.BitmapDataChannel;
import flash.display.MovieClip;
import flash.Lib;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;

class ItemsScroller {
	public var curr_width:Int;
	public var lb:Int;
	public var item_width:Float;
	//public var container_width:Float;
	
	var container:MovieClip;
	var t1:Timer;
	
	var sign:Int;
	var dx:Int;
	var x_left:Int;
	var y_left:Int;
	
	var old_frame_rate:Float;
	
	public function new(x:Int, y:Int, width:Int) {
		t1 = new Timer(Main.DELAY);
		curr_width = width;
		sign = 0;
		dx = Main.DX;
		lb = 150;
		x_left = x;
		y_left = y;
		item_width = 0;
	}
	
	function in_box(x:Float, y:Float):Bool {
		return x > -Main.SCROLL_AREA_DX && x < Main.SCROLL_AREA_DX + curr_width &&
			y > 0 && y < container.height;
	}
	
	function checkDirection(e:MouseEvent) {
		if (!in_box(e.stageX - x_left - container.parent.x,
				e.stageY - y_left - container.parent.y)){
			sign = 0;
			return;
		}
		var lx = e.stageX;
		if (lx > (container.parent.x + x_left + curr_width / 2.0 + lb))
			sign = -1;
		else if (lx < (container.parent.x + x_left + curr_width / 2.0 - lb))
			sign = 1;
		else
			sign = 0;
	}
	
	function moveItems(e) {
		var x1 = 0;
		if (container != null && container.width > curr_width) {
			x1 = Std.int(container.x + sign * dx);
			
			// move right
			if (sign > 0) {
				// check left bound
				if (x1 > x_left)
					x1 = x_left;
			}
			// move left
			else if (sign < 0) {
				// check right bound
				
				//untyped __global__["trace"]([container.width, container_width]);
				
				//if (container.width > curr_width) {
				//	if (x1 + container.width < x_left + (curr_width - item_width))
				//		x1 = Std.int(x_left + (curr_width - item_width) - container.width);
				//}
				//else {
					if (x1 + container.width < x_left + curr_width)
						x1 = Std.int(x_left + curr_width - container.width);
				//}
			}
			
			if(dx != 0)
				container.x = x1;
		}
	}
	
	public function initMouseCheck(container:MovieClip) {
		this.container = container;
		
		//untyped __global__["trace"]([container.width, container_width]);
		
		old_frame_rate = Lib.current.stage.frameRate;
		Lib.current.stage.frameRate = Main.SCROLL_FRAMERATE;
		
		Lib.current.stage.addEventListener(
			MouseEvent.MOUSE_MOVE,
			checkDirection);
		
		var me = this;
		haxe.Timer.delay(function() {
			me.t1.addEventListener(
				TimerEvent.TIMER,
				me.moveItems);
			me.t1.start();
		}, Main.DELAY_SCROLL_INIT);
	}
	
	public function cleanMouseCheck() {
		Lib.current.stage.frameRate = old_frame_rate;
		
		Lib.current.stage.removeEventListener(
			MouseEvent.MOUSE_MOVE,
			checkDirection);
			
		t1.removeEventListener(
			TimerEvent.TIMER,
			moveItems);
		t1.stop();
	}
	
}