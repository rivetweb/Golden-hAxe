package controls.tree {
	import controls.Scrollbar;
	import flash.display.MovieClip;
	import flash.Boot;
	public class Component {
		public function Component(data : * = null) : void { if( !flash.Boot.skip_constructor ) {
			this.container = null;
			this.scrollbar = null;
			this.selectedNode = null;
			this.data = data;
		}}
		
		protected var container : flash.display.MovieClip;
		protected var scrollbar : controls.Scrollbar;
		protected var data : *;
		protected var currentY : Number;
		public var selectedNode : *;
		protected function init() : void {
			if(this.data == null) {
				throw "Need data for tree initialisation";
			}
			this.initByNodeData(this.data,0);
		}
		
		public function initByNodeData(nodeData : *,idx : int) : void {
			nodeData = this.onInitNode(nodeData,idx);
			if(nodeData.nodes != null) {
				var i : int = 0;
				{
					var _g : int = 0, _g1 : Array = nodeData.nodes;
					while(_g < _g1.length) {
						var ch : * = _g1[_g];
						++_g;
						this.initByNodeData(ch,i);
						i++;
					}
				}
			}
		}
		
		public function onInitNode(nodeData : *,idx : int) : * {
			return nodeData;
		}
		
		public function setContainer(container : flash.display.MovieClip) : void {
			this.container = container;
			this.init();
		}
		
		public function getContainer() : flash.display.MovieClip {
			return this.container;
		}
		
		public function setScrollbar(scrollbar : controls.Scrollbar) : void {
			this.scrollbar = scrollbar;
		}
		
		public function getScrollbar() : controls.Scrollbar {
			return this.scrollbar;
		}
		
		public function show() : void {
			this.render();
		}
		
		public function render() : void {
			if(this.data == null || this.container == null) {
				return;
			}
			this.currentY = 0;
			this.renderNode(this.data,0);
			if(this.scrollbar != null) {
				this.scrollbar.onContentChange(this.container);
			}
		}
		
		public function renderNode(nodeData : *,idx : int = 0) : void {
			this.onRenderNode(nodeData,idx);
			if(nodeData.nodes != null) {
				var i : int = 0;
				{
					var _g : int = 0, _g1 : Array = nodeData.nodes;
					while(_g < _g1.length) {
						var ch : * = _g1[_g];
						++_g;
						this.renderNode(ch,i);
						i++;
					}
				}
			}
		}
		
		public function onRenderNode(nodeData : *,idx : int) : void {
			null;
		}
		
		public function findNode(movieClip : flash.display.MovieClip) : * {
			return this._findNode(movieClip,this.data);
		}
		
		protected function _findNode(movieClip : flash.display.MovieClip,nodeData : *) : * {
			if(nodeData.mc == movieClip) {
				return nodeData;
			}
			if(nodeData.nodes != null) {
				{
					var _g : int = 0, _g1 : Array = nodeData.nodes;
					while(_g < _g1.length) {
						var ch : * = _g1[_g];
						++_g;
						var res : * = this._findNode(movieClip,ch);
						if(res != null) {
							return res;
						}
					}
				}
			}
			return null;
		}
		
		public function findNodeBy() : * {
			return this._findNodeBy(this.data,0);
		}
		
		public function onFindNodeBy(nodeData : *,idx : int) : Boolean {
			return false;
		}
		
		protected function _findNodeBy(nodeData : *,idx : int) : * {
			if(this.onFindNodeBy(nodeData,idx)) {
				return nodeData;
			}
			if(nodeData.nodes != null) {
				var i : int = 0;
				{
					var _g : int = 0, _g1 : Array = nodeData.nodes;
					while(_g < _g1.length) {
						var ch : * = _g1[_g];
						++_g;
						var res : * = this._findNodeBy(ch,i);
						if(res != null) {
							return res;
						}
						i++;
					}
				}
			}
			return null;
		}
		
		public function getParent(childNode : *) : * {
			return this._findParent(childNode,this.data);
		}
		
		protected function _findParent(childNode : *,nodeData : *) : * {
			if(nodeData.nodes != null) {
				{
					var _g : int = 0, _g1 : Array = nodeData.nodes;
					while(_g < _g1.length) {
						var ch : * = _g1[_g];
						++_g;
						if(childNode == ch) {
							return nodeData;
						}
						var res : * = this._findParent(childNode,ch);
						if(res != null) {
							return res;
						}
					}
				}
			}
			return null;
		}
		
		public function openNode(nodeData : *) : void {
			if(!nodeData.opened) {
				this.onOpenNode(nodeData);
				this.render();
				nodeData.opened = true;
			}
		}
		
		public function onOpenNode(nodeData : *) : void {
			null;
		}
		
		public function closeNode(nodeData : *) : void {
			if(nodeData.opened) {
				this.onCloseNode(nodeData);
				this.render();
				nodeData.opened = false;
			}
		}
		
		public function onCloseNode(nodeData : *) : void {
			null;
		}
		
		public function triggerNode(nodeData : *) : void {
			if(nodeData.opened) {
				this.closeNode(nodeData);
			}
			else {
				this.openNode(nodeData);
			}
		}
		
		public function onSelectNode(nodeData : *) : void {
			null;
		}
		
		public function setSelectedNode(nodeData : *) : void {
			this.onSelectNode(nodeData);
			this.selectedNode = nodeData;
		}
		
		public function getSelectedNode() : * {
			return this.selectedNode;
		}
		
	}
}
