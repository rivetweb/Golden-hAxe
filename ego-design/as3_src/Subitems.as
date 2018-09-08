package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.text.TextField;
	import flash.display.Shape;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class Subitems extends flash.display.MovieClip {
		public function Subitems() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.group_index = -1;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.bgroup = (function($this:Subitems) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = $this.getChildAt(1);
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Subitems) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.bgroup.addEventListener(flash.events.MouseEvent.CLICK,this.item_click);
			this.bgroup.mouseChildren = false;
			this._label = (function($this:Subitems) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = $this.bgroup.getChildAt(1);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:Subitems) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.items = (function($this:Subitems) : flash.display.MovieClip {
				var $r5 : flash.display.MovieClip;
				var tmp3 : flash.display.DisplayObject = $this.getChildAt(0);
				$r5 = (Std._is(tmp3,flash.display.MovieClip)?tmp3:(function($this:Subitems) : flash.display.DisplayObject {
					var $r6 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r6;
				}($this)));
				return $r5;
			}(this));
			this.box = (function($this:Subitems) : flash.display.Shape {
				var $r7 : flash.display.Shape;
				var tmp4 : flash.display.DisplayObject = $this.items.getChildAt(0);
				$r7 = (Std._is(tmp4,flash.display.Shape)?tmp4:(function($this:Subitems) : flash.display.DisplayObject {
					var $r8 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r8;
				}($this)));
				return $r7;
			}(this));
			var m : flash.display.MovieClip = (function($this:Subitems) : flash.display.MovieClip {
				var $r9 : flash.display.MovieClip;
				var tmp5 : flash.display.DisplayObject = $this.items.getChildAt(1);
				$r9 = (Std._is(tmp5,flash.display.MovieClip)?tmp5:(function($this:Subitems) : flash.display.DisplayObject {
					var $r10 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r10;
				}($this)));
				return $r9;
			}(this));
			m.visible = false;
			this.bg = (function($this:Subitems) : flash.display.MovieClip {
				var $r11 : flash.display.MovieClip;
				var tmp6 : flash.display.DisplayObject = $this.bgroup.getChildAt(0);
				$r11 = (Std._is(tmp6,flash.display.MovieClip)?tmp6:(function($this:Subitems) : flash.display.DisplayObject {
					var $r12 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r12;
				}($this)));
				return $r11;
			}(this));
			this.bgroup.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouse_over);
			this.bgroup.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouse_out);
		}}
		
		public var bgroup : flash.display.MovieClip;
		public var _label : flash.text.TextField;
		public var items : flash.display.MovieClip;
		public var box : flash.display.Shape;
		public var bg : flash.display.MovieClip;
		public var group_index : int;
		public function item_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			var m : flash.display.MovieClip = (function($this:Subitems) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Subitems) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			Main.current_group = this.group_index;
			Main.submenu.hide();
			flash.Lib.current.gotoAndPlay(1,"projects");
		}
		
		protected function mouse_over(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(2);
		}
		
		protected function mouse_out(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(1);
		}
		
	}
}
