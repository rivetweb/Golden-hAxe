package egodesign.controls.tree {
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import egodesign.controls.tree.TreeProjects;
	import flash.text.TextField;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class TreeNodeLevel1 extends flash.display.MovieClip {
		public function TreeNodeLevel1() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this._label = (function($this:TreeNodeLevel1) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(0);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:TreeNodeLevel1) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.oldTextColor = this._label.textColor;
			this.addEventListener(flash.events.MouseEvent.CLICK,this.onClickLevel1);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouseOver);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouseOut);
		}}
		
		protected var oldTextColor : uint;
		protected var _label : flash.text.TextField;
		public function setText(s : String) : void {
			this._label.text = s;
		}
		
		protected function onClickLevel1(m : flash.events.MouseEvent) : void {
			var treeProjects : egodesign.controls.tree.TreeProjects = egodesign.Utils.getTreeProjects();
			var res : * = treeProjects.findNode(this);
			treeProjects.triggerNode(res);
		}
		
		protected function mouseOver(e : flash.events.MouseEvent) : void {
			this._label.textColor = Main.SUBMENU_ITEMS_COLOR;
		}
		
		protected function mouseOut(e : flash.events.MouseEvent) : void {
			this._label.textColor = this.oldTextColor;
		}
		
	}
}
