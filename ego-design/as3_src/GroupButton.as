package  {
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.Boot;
	public class GroupButton extends flash.display.MovieClip {
		public function GroupButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.buttonMode = true;
			this.useHandCursor = true;
			this._label = (function($this:GroupButton) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(2);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:GroupButton) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.mouseChildren = false;
			this.bg = (function($this:GroupButton) : flash.display.MovieClip {
				var $r3 : flash.display.MovieClip;
				var tmp2 : flash.display.DisplayObject = $this.getChildAt(0);
				$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:(function($this:GroupButton) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.addEventListener(flash.events.MouseEvent.CLICK,this.item_click);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouse_over);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouse_out);
		}}
		
		public var _label : flash.text.TextField;
		public var bg : flash.display.MovieClip;
		protected function item_click(e : flash.events.MouseEvent) : void {
			if((function($this:GroupButton) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:GroupButton) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this)) == Main.submenu.items[Main.submenu.items.length - 1] && Main.submenu.active_item != null) Main.submenu.remove_listener();
			Main.sound_click1.play();
			Main.submenu.set_active_item((function($this:GroupButton) : flash.display.MovieClip {
				var $r3 : flash.display.MovieClip;
				var tmp2 : * = e.currentTarget;
				$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:(function($this:GroupButton) : * {
					var $r4 : *;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this)));
		}
		
		protected function mouse_over(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(2);
		}
		
		protected function mouse_out(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(1);
		}
		
	}
}
