package egodesign.controls.gallery {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.events.TimerEvent;
	import haxe.Timer;
	import flash.utils.Timer;
	import flash.Boot;
	public class ItemsScroller {
		public function ItemsScroller(x : int = 0,y : int = 0,width : int = 0) : void { if( !flash.Boot.skip_constructor ) {
			this.t1 = new flash.utils.Timer(Main.DELAY);
			this.curr_width = width;
			this.sign = 0;
			this.dx = Main.DX;
			this.lb = 150;
			this.x_left = x;
			this.y_left = y;
			this.item_width = 0;
		}}
		
		public var curr_width : int;
		public var lb : int;
		public var item_width : Number;
		protected var container : flash.display.MovieClip;
		protected var t1 : flash.utils.Timer;
		protected var sign : int;
		protected var dx : int;
		protected var x_left : int;
		protected var y_left : int;
		protected var old_frame_rate : Number;
		protected function in_box(x : Number,y : Number) : Boolean {
			return x > -Main.SCROLL_AREA_DX && x < Main.SCROLL_AREA_DX + this.curr_width && y > 0 && y < this.container.height;
		}
		
		protected function checkDirection(e : flash.events.MouseEvent) : void {
			if(!this.in_box(e.stageX - this.x_left - this.container.parent.x,e.stageY - this.y_left - this.container.parent.y)) {
				this.sign = 0;
				return;
			}
			var lx : Number = e.stageX;
			if(lx > (this.container.parent.x + this.x_left + this.curr_width / 2.0 + this.lb)) this.sign = -1;
			else if(lx < (this.container.parent.x + this.x_left + this.curr_width / 2.0 - this.lb)) this.sign = 1;
			else this.sign = 0;
		}
		
		protected function moveItems(e : *) : void {
			var x1 : int = 0;
			if(this.container != null && this.container.width > this.curr_width) {
				x1 = Std._int(this.container.x + this.sign * this.dx);
				if(this.sign > 0) {
					if(x1 > this.x_left) x1 = this.x_left;
				}
				else if(this.sign < 0) {
					if(x1 + this.container.width < this.x_left + this.curr_width) x1 = Std._int(this.x_left + this.curr_width - this.container.width);
				}
				if(this.dx != 0) this.container.x = x1;
			}
		}
		
		public function initMouseCheck(container : flash.display.MovieClip) : void {
			this.container = container;
			this.old_frame_rate = flash.Lib.current.stage.frameRate;
			flash.Lib.current.stage.frameRate = Main.SCROLL_FRAMERATE;
			flash.Lib.current.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE,this.checkDirection);
			var me : egodesign.controls.gallery.ItemsScroller = this;
			haxe.Timer.delay(function() : void {
				me.t1.addEventListener(flash.events.TimerEvent.TIMER,me.moveItems);
				me.t1.start();
			},Main.DELAY_SCROLL_INIT);
		}
		
		public function cleanMouseCheck() : void {
			flash.Lib.current.stage.frameRate = this.old_frame_rate;
			flash.Lib.current.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE,this.checkDirection);
			this.t1.removeEventListener(flash.events.TimerEvent.TIMER,this.moveItems);
			this.t1.stop();
		}
		
	}
}
