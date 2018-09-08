package ;

import flash.display.MovieClip;
import feffects.Tween;
import feffects.easing.Linear;

class InfinitScroller {
	private var x_interval:Int;
	
	private var items:Array<MovieClip>;
	
	private var container:MovieClip;
	
	private var index:Int;
	private var size:Int;
	
	public function new(container:MovieClip, items:Array<MovieClip>) {
		this.items = items;
		this.container = container;
		index = 0;
		size = 5;
		x_interval = 20;
	}
	
	function move(e: Float) {
		var x:Float = 0;
		for (i in 0...size) {
			var j = index + i;
			if (j >= items.length)
				j -= items.length;
			items[j].x = x + e;
			x += items[j].width + x_interval;
		}
	}

	function finished(e: Float) {
		index++;
		show();
	}
	
	public function show() {
		for (i in items)
			i.visible = false;
		
		if (index >= items.length)
			index = 0;
		
		var x:Float = 0;
		for (i in 0...size) {
			var j = index + i;
			if (j >= items.length)
				j -= items.length;
			items[j].visible = true;
			items[j].x = x;
			x += items[i].width + x_interval;
		}
		
		var tween = new Tween(
			0, -items[index].width - x_interval,
			Main.SCROLLER_DURATION, Linear.easeNone);
		tween.setTweenHandlers(move, finished);
		tween.start();
	}
}