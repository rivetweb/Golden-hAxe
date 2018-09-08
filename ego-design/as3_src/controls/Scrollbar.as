package controls {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.Lib;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.Boot;
	public class Scrollbar {
		public function Scrollbar(content : flash.display.MovieClip = null,area : flash.display.MovieClip = null,scroller : flash.display.MovieClip = null,scrollable_area : flash.display.MovieClip = null) : void { if( !flash.Boot.skip_constructor ) {
			this.content = content;
			this.area = area;
			this.scroller = scroller;
			this.scrollable_area = scrollable_area;
			this.content.mask = this.area;
			this.scrollSpeed = 0.5;
			this.scrollVelocity = 3;
			this.onContentChange(content);
			scroller.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,this.scroller_drag);
			scroller.addEventListener(flash.events.MouseEvent.MOUSE_UP,this.scroller_drop);
			flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME,this.on_scroll);
			flash.Lib.current.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL,this.scrollerWheel);
		}}
		
		protected var content : flash.display.MovieClip;
		protected var area : flash.display.MovieClip;
		protected var scroller : flash.display.MovieClip;
		protected var scrollable_area : flash.display.MovieClip;
		protected var sd : Number;
		protected var sr : Number;
		protected var cd : Number;
		protected var cr : Number;
		protected var new_y : Number;
		protected var drag_area : flash.geom.Rectangle;
		protected var scrollSpeed : Number;
		protected var scrollVelocity : Number;
		public function onContentChange(content : flash.display.MovieClip) : void {
			this.sr = this.area.height / this.content.height;
			this.sd = this.scrollable_area.height - this.scroller.height;
			this.cd = this.content.height - this.area.height;
			this.cr = this.cd / this.sd;
			this.drag_area = new flash.geom.Rectangle(0,0,0,this.scrollable_area.height - this.scroller.height + 2);
			if(this.content.height <= this.area.height) {
				this.scroller.visible = this.scrollable_area.visible = false;
			}
			else {
				this.scroller.visible = this.scrollable_area.visible = true;
			}
		}
		
		public function setWheelVelocity(k : Number) : void {
			this.scrollVelocity = k;
		}
		
		public function setScrollSpeed(speed : Number) : void {
			if(this.scrollSpeed < 0 || this.scrollSpeed > 1) {
				this.scrollSpeed = 0.50;
			}
			else {
				this.scrollSpeed = speed;
			}
		}
		
		protected function scroller_drag(me : flash.events.MouseEvent) : void {
			var stage : flash.display.Stage = flash.Lib.current.stage;
			me.target.startDrag(false,this.drag_area);
			stage.addEventListener(flash.events.MouseEvent.MOUSE_UP,this.up);
		}
		
		protected function scroller_drop(me : flash.events.MouseEvent) : void {
			var stage : flash.display.Stage = flash.Lib.current.stage;
			me.target.stopDrag();
			stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP,this.up);
		}
		
		protected function up(me : flash.events.MouseEvent) : void {
			this.scroller.stopDrag();
		}
		
		protected function scrollerWheel(m : flash.events.MouseEvent) : void {
			if(!this.scroller.visible) {
				return;
			}
			var y : Number = this.scroller.y;
			y = this.scroller.y - this.scrollVelocity * m.delta;
			if(y < 0) {
				y = 0;
			}
			else if(y > this.scrollable_area.height - this.scroller.height) {
				y = this.scrollable_area.height - this.scroller.height;
			}
			this.scroller.y = y;
		}
		
		protected function on_scroll(e : flash.events.Event) : void {
			this.new_y = this.area.y + this.scrollable_area.y * this.cr - this.scroller.y * this.cr;
			this.content.y += (this.new_y - this.content.y) * this.scrollSpeed;
		}
		
	}
}
