package egodesign.controls.tree {
	import flash.display.MovieClip;
	import egodesign.Utils;
	import flash.events.Event;
	import egodesign.controls.tree.TreeProjects;
	import flash.Boot;
	public class TreeProjectsContainer extends flash.display.MovieClip {
		public function TreeProjectsContainer() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init);
		}}
		
		protected function init(e : flash.events.Event) : void {
			var treeProjects : egodesign.controls.tree.TreeProjects = egodesign.Utils.getTreeProjects();
			treeProjects.setContainer(this);
		}
		
	}
}
