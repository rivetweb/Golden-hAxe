package egodesign.controls.tree;

import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;
import egodesign.Utils;

class TreeProjectsContainer extends MovieClip {

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event) {
		var treeProjects = Utils.getTreeProjects();
		treeProjects.setContainer(this);
	}
}