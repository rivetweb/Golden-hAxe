package egodesign.controls.tree {
	import controls.Scrollbar;
	import egodesign.Utils;
	import flash.display.MovieClip;
	import egodesign.controls.tree.TreeProjects;
	import flash.Lib;
	import flash.events.Event;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class TreeScrollbar extends flash.display.MovieClip {
		public function TreeScrollbar() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init);
		}}
		
		protected function init(e : flash.events.Event) : void {
			var treeScrollArea : flash.display.MovieClip = (function($this:TreeScrollbar) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = flash.Lib.current.getChildByName("treeScrollArea");
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:TreeScrollbar) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			var treeScroller : flash.display.MovieClip = (function($this:TreeScrollbar) : flash.display.MovieClip {
				var $r3 : flash.display.MovieClip;
				var tmp2 : flash.display.DisplayObject = $this.getChildByName("treeScroller");
				$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:(function($this:TreeScrollbar) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			var treeScrollableArea : flash.display.MovieClip = (function($this:TreeScrollbar) : flash.display.MovieClip {
				var $r5 : flash.display.MovieClip;
				var tmp3 : flash.display.DisplayObject = $this.getChildByName("treeScrollableArea");
				$r5 = (Std._is(tmp3,flash.display.MovieClip)?tmp3:(function($this:TreeScrollbar) : flash.display.DisplayObject {
					var $r6 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r6;
				}($this)));
				return $r5;
			}(this));
			var treeProjects : egodesign.controls.tree.TreeProjects = egodesign.Utils.getTreeProjects();
			treeProjects.show();
			var scrollbar : controls.Scrollbar = new controls.Scrollbar(treeProjects.getContainer(),treeScrollArea,treeScroller,treeScrollableArea);
			scrollbar.setScrollSpeed(Main.SCROLL_SPEED);
			scrollbar.setWheelVelocity(Main.SCROLL_WHEEL_K);
			treeProjects.setScrollbar(scrollbar);
			egodesign.Utils.setSelectedNode();
		}
		
	}
}
