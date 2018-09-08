package egodesign.controls.tree;

import flash.display.MovieClip;
import flash.text.TextField;
import flash.events.MouseEvent;
import egodesign.Utils;

class TreeNodeLevel1 extends MovieClip {

	private var oldTextColor:UInt;
	private var label:TextField;
	
	public function new() {
		super();
	
		label = cast(getChildAt(0), TextField);
		oldTextColor = label.textColor;
		
		addEventListener(MouseEvent.CLICK, onClickLevel1);
		addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}
	
	public function setText(s:String) {
		label.text = s;
	}
	
	private function onClickLevel1(m:MouseEvent) {
		var treeProjects = Utils.getTreeProjects();
		var res = treeProjects.findNode(this);
		
		treeProjects.triggerNode(res);
	}
	
	private function mouseOver(e:MouseEvent) {
		label.textColor = Main.SUBMENU_ITEMS_COLOR;
	}
	
	private function mouseOut(e:MouseEvent) {
		label.textColor = oldTextColor;
	}
	
}