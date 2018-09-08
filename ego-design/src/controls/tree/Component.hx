package controls.tree;

import controls.Scrollbar;
import flash.display.MovieClip;

typedef NodeData = {
	var name:String;
	var type:String;
	var mc:MovieClip;
	var opened:Bool;
	var data:Dynamic;
	var nodes:Array<NodeData>;
}

class Component {
	// container for tree component
	private var container:MovieClip;
	
	// container for tree component
	private var scrollbar:Scrollbar;
	
	// nodes data for tree
	private var data:NodeData;
	
	// next Y coord for node
	private var currentY:Float;
	
	// current selected node
	public var selectedNode:NodeData;
		
	public function new(data:NodeData) {
		this.container = null;
		this.scrollbar = null;
		this.selectedNode = null;
		this.data = data;
	}
	
	private function init() {
		if (data == null) {
			throw "Need data for tree initialisation";
		}
		
		initByNodeData(data, 0);
	}
	
	public function initByNodeData(nodeData:NodeData, idx:Int) {
		nodeData = onInitNode(nodeData, idx);
		
		if (nodeData.nodes != null) {
			var i = 0;
			for (ch in nodeData.nodes) {
				initByNodeData(ch, i);
				i++;
			}
		}
	}
	
	public function onInitNode(nodeData:NodeData, idx:Int):NodeData {
		return nodeData;
	}
	
	public function setContainer(container:MovieClip) {
		this.container = container;
		init();
	}
	
	public function getContainer():MovieClip {
		return this.container;
	}
	
	public function setScrollbar(scrollbar:Scrollbar) {
		this.scrollbar = scrollbar;
	}
	
	public function getScrollbar():Scrollbar {
		return this.scrollbar;
	}
	
	public function show() {
		render();
	}
	
	public function render() {
		if (this.data == null || this.container == null) {
			return;
		}
		
		currentY = 0;
		renderNode(data, 0);
		
		//trace(container.height);
		
		if (scrollbar != null) {
			scrollbar.onContentChange(container);
		}
	}
	
	public function renderNode(nodeData:NodeData, idx:Int = 0) {
		onRenderNode(nodeData, idx);
		
		if (nodeData.nodes != null) {
			var i = 0;
			for (ch in nodeData.nodes) {
				renderNode(ch, i);
				i++;
			}
		}
	}
	
	public function onRenderNode(nodeData:NodeData, idx:Int) {
	}
	
	public function findNode(movieClip:MovieClip):NodeData {
		return _findNode(movieClip, data);
	}
	
	private function _findNode(movieClip:MovieClip, nodeData:NodeData):NodeData {
		if (nodeData.mc == movieClip) {
			return nodeData;
		}
		
		if (nodeData.nodes != null) {
			for (ch in nodeData.nodes) {
				var res = _findNode(movieClip, ch);
				if (res != null) {
					return res;
				}
			}
		}
		
		return null;
	}
	
	public function findNodeBy():NodeData {
		return _findNodeBy(data, 0);
	}
	
	public function onFindNodeBy(nodeData:NodeData, idx:Int):Bool {
		return false;
	}
	
	private function _findNodeBy(nodeData:NodeData, idx:Int):NodeData {
		if (onFindNodeBy(nodeData, idx)) {
			return nodeData;
		}
		
		if (nodeData.nodes != null) {
			var i = 0;
			for (ch in nodeData.nodes) {
				var res = _findNodeBy(ch, i);
				if (res != null) {
					return res;
				}
				i++;
			}
		}
		
		return null;
	}
	
	public function getParent(childNode:NodeData):NodeData {
		return _findParent(childNode, data);
	}
	
	private function _findParent(childNode:NodeData, nodeData:NodeData):NodeData {
		if (nodeData.nodes != null) {
			for (ch in nodeData.nodes) {
				if (childNode == ch) {
					return nodeData;
				}
				
				var res = _findParent(childNode, ch);
				if (res != null) {
					return res;
				}
			}
		}
		
		return null;
	}
	
	public function openNode(nodeData:NodeData) {
		if (!nodeData.opened) {
			onOpenNode(nodeData);
			render();
			nodeData.opened = true;
		}
	}
	
	public function onOpenNode(nodeData:NodeData) {
	}
	
	public function closeNode(nodeData:NodeData) {
		if (nodeData.opened) {
			onCloseNode(nodeData);
			render();
			nodeData.opened = false;
		}
	}
	
	public function onCloseNode(nodeData:NodeData) {
	}
	
	public function triggerNode(nodeData:NodeData) {
		if (nodeData.opened) {
			closeNode(nodeData);
		}
		else {
			openNode(nodeData);
		}
	}
	
	public function onSelectNode(nodeData:NodeData) {
	}
	
	public function setSelectedNode(nodeData:NodeData) {
		onSelectNode(nodeData);
		selectedNode = nodeData;
	}
	
	public function getSelectedNode():NodeData {
		return selectedNode;
	}
}