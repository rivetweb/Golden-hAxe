package egodesign.controls.tree {
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import egodesign.controls.tree.TreeProjects;
	import flash.text.TextField;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class TreeNodeLevel2 extends flash.display.MovieClip {
		public function TreeNodeLevel2() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this._label = (function($this:TreeNodeLevel2) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(0);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:TreeNodeLevel2) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.oldTextColor = this._label.textColor;
			this.arrow = (function($this:TreeNodeLevel2) : flash.display.MovieClip {
				var $r3 : flash.display.MovieClip;
				var tmp2 : flash.display.DisplayObject = $this.getChildAt(1);
				$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:(function($this:TreeNodeLevel2) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.groupIndex = 0;
			this.projectIndex = 0;
			this.opened = false;
			this.addEventListener(flash.events.MouseEvent.CLICK,this.onClickLevel2);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouseOver);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouseOut);
		}}
		
		protected var oldTextColor : uint;
		protected var _label : flash.text.TextField;
		protected var arrow : flash.display.MovieClip;
		protected var groupIndex : int;
		protected var projectIndex : int;
		protected var opened : Boolean;
		public function setIndexes(groupi : int,projecti : int) : void {
			this.groupIndex = groupi;
			this.projectIndex = projecti;
		}
		
		public function setText(s : String) : void {
			this._label.text = s;
		}
		
		public function setState(opened : Boolean) : void {
			this.opened = opened;
			if(!this.opened) {
				this.arrow.rotation = 0;
			}
			else {
				this.arrow.rotation = 90;
			}
		}
		
		protected function onClickLevel2(m : flash.events.MouseEvent) : void {
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
