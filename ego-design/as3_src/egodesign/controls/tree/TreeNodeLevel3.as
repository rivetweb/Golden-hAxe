package egodesign.controls.tree {
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import egodesign.controls.tree.TreeProjects;
	import flash.text.TextField;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class TreeNodeLevel3 extends flash.display.MovieClip {
		public function TreeNodeLevel3() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this._label = (function($this:TreeNodeLevel3) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(0);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:TreeNodeLevel3) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.oldTextColor = this._label.textColor;
			this.groupIndex = 0;
			this.projectIndex = 0;
			this.imageIndex = 0;
			this.selected = false;
			this.addEventListener(flash.events.MouseEvent.CLICK,this.onClickLevel3);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouseOver);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouseOut);
		}}
		
		protected var oldTextColor : uint;
		protected var _label : flash.text.TextField;
		protected var groupIndex : int;
		protected var projectIndex : int;
		protected var imageIndex : int;
		protected var selected : Boolean;
		public function setIndexes(groupi : int,projecti : int,imagei : int) : void {
			this.groupIndex = groupi;
			this.projectIndex = projecti;
			this.imageIndex = imagei;
		}
		
		public function setText(s : String) : void {
			this._label.text = s;
		}
		
		public function selectNode() : void {
			this.selected = true;
			this._label.textColor = Main.SUBMENU_ITEMS_COLOR;
		}
		
		public function unselectNode() : void {
			this.selected = false;
			this._label.textColor = this.oldTextColor;
		}
		
		protected function onClickLevel3(m : flash.events.MouseEvent) : void {
			var treeProjects : egodesign.controls.tree.TreeProjects = egodesign.Utils.getTreeProjects();
			var res : * = treeProjects.findNode(this);
			treeProjects.setSelectedNode(res);
			egodesign.Utils.showProjectImage(this.groupIndex,this.projectIndex,this.imageIndex);
		}
		
		protected function mouseOver(e : flash.events.MouseEvent) : void {
			if(!this.selected) {
				this._label.textColor = Main.SUBMENU_ITEMS_COLOR;
			}
		}
		
		protected function mouseOut(e : flash.events.MouseEvent) : void {
			if(!this.selected) {
				this._label.textColor = this.oldTextColor;
			}
		}
		
	}
}
