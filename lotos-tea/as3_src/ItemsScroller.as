package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.events.TimerEvent;
	import haxe.Timer;
	import flash.utils.Timer;
	import flash.Boot;
	public class ItemsScroller {
		public function ItemsScroller() : void { if( !flash.Boot.skip_constructor ) {
			this.t1 = new flash.utils.Timer(Main.DELAY);
			this.curr_width = 930;
			this.sign = 0;
			this.dx = Main.DX;
			this.lb = 50;
			this.bx = Std._int(this.curr_width / 2) - this.lb;
		}}
		
		protected var container : flash.display.MovieClip;
		protected var t1 : flash.utils.Timer;
		protected var curr_width : int;
		protected var sign : int;
		protected var dx : int;
		protected var lb : int;
		protected var bx : int;
		protected function checkDirection(e : flash.events.MouseEvent) : void {
			var lx : Number = e.stageX;
			if(lx > (this.curr_width / 2.0 + this.bx)) this.sign = -1;
			else if(lx < (this.curr_width / 2.0 - this.bx)) this.sign = 1;
			else this.sign = 0;
		}
		
		protected function moveItems(e : *) : void {
			var x1 : int = 0;
			if(this.container != null && this.container.width > this.curr_width) {
				x1 = Std._int(this.container.x + this.sign * this.dx);
				if(this.sign > 0) {
					if(x1 > this.lb) x1 = this.lb;
				}
				else if(this.sign < 0) {
					if(x1 + this.container.width < this.curr_width - this.lb) x1 = Std._int(this.curr_width - this.lb - this.container.width);
				}
				if(this.dx != 0) this.container.x = x1;
			}
		}
		
		public function initMouseCheck(container : flash.display.MovieClip) : void {
			this.container = container;
			flash.Lib.current.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE,this.checkDirection);
			var me : ItemsScroller = this;
			haxe.Timer.delay(function() : void {
				me.t1.addEventListener(flash.events.TimerEvent.TIMER,me.moveItems);
				me.t1.start();
			},Main.DELAY_SCROLL_INIT);
		}
		
		public function cleanMouseCheck() : void {
			flash.Lib.current.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE,this.checkDirection);
			this.t1.removeEventListener(flash.events.TimerEvent.TIMER,this.moveItems);
			this.t1.stop();
		}
		
	}
}
