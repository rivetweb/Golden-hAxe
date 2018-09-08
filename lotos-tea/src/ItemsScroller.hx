package ;

import flash.display.BitmapDataChannel;
import flash.display.MovieClip;
import flash.Lib;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;

class ItemsScroller {
	var container:MovieClip;
	var t1:Timer;
	
	var curr_width:Int;
	var sign:Int;
	var dx:Int;
	var lb:Int;
	var bx:Int;
	
	public function new() {
		t1 = new Timer(Main.DELAY);
		curr_width = 930;
		sign = 0;
		dx = Main.DX;
		lb = 50;
		bx = Std.int(curr_width / 2) - lb;
	}
	
	function checkDirection(e:MouseEvent) {
		var lx = e.stageX;
		if (lx > (curr_width / 2.0 + bx))
			sign = -1;
		else if (lx < (curr_width / 2.0 - bx))
			sign = 1;
		else
			sign = 0;
		//trace(sign);
	}
	
	function moveItems(e) {
		var x1 = 0;
		if (container != null && container.width > curr_width) {
			x1 = Std.int(container.x + sign * dx);
			// move right
			if(sign > 0){
				// check left bound
				if (x1 > lb)
					x1 = lb;
			}
			
			// move left
			else if (sign < 0){
				// check right bound
				if (x1 + container.width < curr_width - lb)
					x1 = Std.int(curr_width - lb - container.width);
			}
			
			if(dx != 0)
				container.x = x1;
				
			//if (!tween || !tween.isPlaying)
			//	if(dx != 0)
			//		tween = new Tween(container, "x", Strong.easeOut, container.x, dx * 50, 24, false);
			//
		}
	}
	
	public function initMouseCheck(container:MovieClip) {
		this.container = container;
		
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
		Lib.current.stage.removeEventListener(
			MouseEvent.MOUSE_MOVE,
			checkDirection);
			
		t1.removeEventListener(
			TimerEvent.TIMER,
			moveItems);
		t1.stop();
	}
	
}