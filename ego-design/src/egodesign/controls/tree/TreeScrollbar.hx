package egodesign.controls.tree;

import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;

import egodesign.Utils;
import controls.Scrollbar;

class TreeScrollbar extends MovieClip {

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event) {
		var treeScrollArea = cast(Lib.current.getChildByName("treeScrollArea"), MovieClip);
		var treeScroller = cast(this.getChildByName("treeScroller"), MovieClip);
		var treeScrollableArea = cast(this.getChildByName("treeScrollableArea"), MovieClip);
		
		var treeProjects = Utils.getTreeProjects();
		treeProjects.show();
		
		// add scrollbar for projects tree
		var scrollbar = new Scrollbar(
			treeProjects.getContainer(),
			treeScrollArea,
			treeScroller,
			treeScrollableArea
		);
		scrollbar.setScrollSpeed(Main.SCROLL_SPEED);
		scrollbar.setWheelVelocity(Main.SCROLL_WHEEL_K);
		
		treeProjects.setScrollbar(scrollbar);
		
		Utils.setSelectedNode();
	}
	
}