package egodesign.controls.tree;

import flash.display.MovieClip;
import flash.text.TextField;
import flash.events.MouseEvent;
import flash.Lib;
import egodesign.Utils;

class TreeNodeLevel3 extends MovieClip {
	private var oldTextColor:UInt;
	private var label:TextField;
	
	private var groupIndex:Int;
	private var projectIndex:Int;
	private var imageIndex:Int;
	
	private var selected:Bool;
	
	public function new() {
		super();
		
		label = cast(getChildAt(0), TextField);
		oldTextColor = label.textColor;
		
		groupIndex = 0;
		projectIndex = 0;
		imageIndex = 0;
		selected = false;
		
		addEventListener(MouseEvent.CLICK, onClickLevel3);
		addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}
	
	public function setIndexes(groupi:Int, projecti:Int, imagei:Int) {
		groupIndex = groupi;
		projectIndex = projecti;
		imageIndex = imagei;
	}
	
	public function setText(s:String) {
		label.text = s;
	}
	
	public function selectNode() {
		selected = true;
		label.textColor = Main.SUBMENU_ITEMS_COLOR;
	}
	
	public function unselectNode() {
		selected = false;
		label.textColor = oldTextColor;
	}
	
	private function onClickLevel3(m:MouseEvent) {
		var treeProjects = Utils.getTreeProjects();
		var res = treeProjects.findNode(this);
		
		treeProjects.setSelectedNode(res);
		Utils.showProjectImage(groupIndex, projectIndex, imageIndex);
	}
	
	private function mouseOver(e:MouseEvent) {
		if (!selected) {
			label.textColor = Main.SUBMENU_ITEMS_COLOR;
		}
	}
	
	private function mouseOut(e:MouseEvent) {
		if (!selected) {
			label.textColor = oldTextColor;
		}
	}
}