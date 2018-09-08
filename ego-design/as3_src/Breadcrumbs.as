package  {
	import egodesign.Utils;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class Breadcrumbs extends flash.display.MovieClip {
		public function Breadcrumbs() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.text = null;
			if(Main.current_group >= 0) {
				var m : flash.display.MovieClip = (function($this:Breadcrumbs) : flash.display.MovieClip {
					var $r : flash.display.MovieClip;
					var tmp : flash.display.DisplayObject = $this.getChildAt(3);
					$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Breadcrumbs) : flash.display.DisplayObject {
						var $r2 : flash.display.DisplayObject;
						throw "Class cast error";
						return $r2;
					}($this)));
					return $r;
				}(this));
				this.text = (function($this:Breadcrumbs) : flash.text.TextField {
					var $r3 : flash.text.TextField;
					var tmp2 : flash.display.DisplayObject = m.getChildAt(0);
					$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:Breadcrumbs) : flash.display.DisplayObject {
						var $r4 : flash.display.DisplayObject;
						throw "Class cast error";
						return $r4;
					}($this)));
					return $r3;
				}(this));
				this.text.autoSize = flash.text.TextFieldAutoSize.LEFT;
				this.text.text = egodesign.Utils.getGroupXmlData().node.resolve("name").getInnerData();
				if(Main.current_project >= 0) this.init_part();
			}
		}}
		
		protected var text : flash.text.TextField;
		protected function init_part() : void {
			var p : flash.display.MovieClip = flash.Lib.attach("breadcrumb_part");
			p.x = this.text.textWidth + 18;
			var br_part : flash.text.TextField = (function($this:Breadcrumbs) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = p.getChildAt(1);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:Breadcrumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			br_part.text = egodesign.Utils.getProjectXmlData(Main.current_project).node.resolve("name").getInnerData();
			this.addChild(p);
		}
		
	}
}
