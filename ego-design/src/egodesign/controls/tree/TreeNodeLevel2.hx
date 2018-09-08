package egodesign.controls.tree;

import flash.display.MovieClip;
import flash.text.TextField;
import flash.events.MouseEvent;
import egodesign.Utils;

class TreeNodeLevel2 extends MovieClip {
	private var oldTextColor:UInt;
	private var label:TextField;
	private var arrow:MovieClip;
	
	private var groupIndex:Int;
	private var projectIndex:Int;
	
	private var opened:Bool;
	
	public function new() {
		super();
		
		label = cast(getChildAt(0), TextField);
		oldTextColor = label.textColor;
		arrow = cast(getChildAt(1), MovieClip);
		
		groupIndex = 0;
		projectIndex = 0;
		opened = false;
		
		addEventListener(MouseEvent.CLICK, onClickLevel2);
		addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}
	
	public function setIndexes(groupi:Int, projecti:Int) {
		groupIndex = groupi;
		projectIndex = projecti;
	}
	
	public function setText(s:String) {
		label.text = s;
	}
	
	public function setState(opened:Bool) {
		this.opened = opened;
		if (!this.opened) {
			arrow.rotation = 0;
		}
		else {
			arrow.rotation = 90;
		}
	}
	
	private function onClickLevel2(m:MouseEvent) {
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