package  {
	import feffects.easing.Linear;
	import flash.display.MovieClip;
	import feffects.Tween;
	import flash.Boot;
	public class InfinitScroller {
		public function InfinitScroller(container : flash.display.MovieClip = null,items : Array = null) : void { if( !flash.Boot.skip_constructor ) {
			this.items = items;
			this.container = container;
			this.index = 0;
			this.size = 5;
			this.x_interval = 20;
		}}
		
		protected var x_interval : int;
		protected var items : Array;
		protected var container : flash.display.MovieClip;
		protected var index : int;
		protected var size : int;
		protected function move(e : Number) : void {
			var x : Number = 0;
			{
				var _g1 : int = 0, _g : int = this.size;
				while(_g1 < _g) {
					var i : int = _g1++;
					var j : int = this.index + i;
					if(j >= this.items.length) j -= this.items.length;
					this.items[j].x = x + e;
					x += this.items[j].width + this.x_interval;
				}
			}
		}
		
		protected function finished(e : Number) : void {
			this.index++;
			this.show();
		}
		
		public function show() : void {
			{
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var i : flash.display.MovieClip = _g1[_g];
					++_g;
					i.visible = false;
				}
			}
			if(this.index >= this.items.length) this.index = 0;
			var x : Number = 0;
			{
				var _g12 : int = 0, _g2 : int = this.size;
				while(_g12 < _g2) {
					var i2 : int = _g12++;
					var j : int = this.index + i2;
					if(j >= this.items.length) j -= this.items.length;
					this.items[j].visible = true;
					this.items[j].x = x;
					x += this.items[i2].width + this.x_interval;
				}
			}
			var tween : feffects.Tween = new feffects.Tween(0,-this.items[this.index].width - this.x_interval,Main.SCROLLER_DURATION,feffects.easing.Linear.easeNone);
			tween.setTweenHandlers(this.move,this.finished);
			tween.start();
		}
		
	}
}
