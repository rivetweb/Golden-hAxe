package egodesign.controls.tree {
	import flash.Lib;
	import flash.text.TextField;
	import controls.tree.Component;
	import flash.Boot;
	import haxe.xml.Fast;
	public class TreeProjects extends controls.tree.Component {
		public function TreeProjects(xmlData : haxe.xml.Fast = null) : void { if( !flash.Boot.skip_constructor ) {
			super(this.convertDataFromXml(xmlData));
		}}
		
		public function convertDataFromXml(xmlData : haxe.xml.Fast) : * {
			var result : * = { name : "Root", type : "root", nodes : [], mc : null, data : null, opened : true}
			var groupIndex : int = 0;
			{ var $it : * = xmlData.getElements();
			while( $it.hasNext() ) { var group : haxe.xml.Fast = $it.next();
			{
				var group_data : * = { name : group.node.resolve("name").getInnerData(), type : "level1", nodes : [], mc : null, data : null, opened : true}
				var projectIndex : int = 0;
				{ var $it2 : * = group.nodes.resolve("project").iterator();
				while( $it2.hasNext() ) { var project : haxe.xml.Fast = $it2.next();
				{
					var project_data : * = { name : project.node.resolve("name").getInnerData(), type : "level2", nodes : [], mc : null, data : { groupIndex : groupIndex}, opened : true}
					{ var $it3 : * = project.node.resolve("images").getElements();
					while( $it3.hasNext() ) { var img : haxe.xml.Fast = $it3.next();
					{
						var image_data : * = { name : img.getInnerData(), type : "level3", nodes : null, mc : null, data : { groupIndex : groupIndex, projectIndex : projectIndex}, opened : true}
						project_data.nodes.push(image_data);
					}
					}}
					group_data.nodes.push(project_data);
					projectIndex++;
				}
				}}
				result.nodes.push(group_data);
				groupIndex++;
			}
			}}
			return result;
		}
		
		public override function onInitNode(nodeData : *,idx : int) : * {
			var _label : flash.text.TextField;
			switch(nodeData.type) {
			case "level1":{
				nodeData.opened = false;
				nodeData.mc = flash.Lib.attach("TreeNodeLevel1");
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.visible = true;
				this.container.addChild(nodeData.mc);
			}break;
			case "level2":{
				nodeData.opened = false;
				nodeData.mc = flash.Lib.attach("TreeNodeLevel2");
				nodeData.mc.visible = false;
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.setIndexes(nodeData.data.groupIndex,idx);
				nodeData.mc.setState(nodeData.opened);
				this.container.addChild(nodeData.mc);
			}break;
			case "level3":{
				nodeData.opened = true;
				nodeData.mc = flash.Lib.attach("TreeNodeLevel3");
				nodeData.mc.visible = false;
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.setIndexes(nodeData.data.groupIndex,nodeData.data.projectIndex,idx);
				this.container.addChild(nodeData.mc);
			}break;
			}
			return nodeData;
		}
		
		public override function onRenderNode(nodeData : *,idx : int) : void {
			if(nodeData.type == "root") {
				return;
			}
			if(nodeData.mc.visible) {
				nodeData.mc.y = this.currentY;
				this.currentY += nodeData.mc.height;
			}
		}
		
		public override function onCloseNode(nodeData : *) : void {
			switch(nodeData.type) {
			case "level1":{
				this.closeNodeLevel2(nodeData);
			}break;
			case "level2":{
				nodeData.mc.setState(false);
				this.closeNodeLevel2(nodeData);
			}break;
			}
		}
		
		protected function closeNodeLevel2(nodeData : *) : void {
			if(nodeData.nodes == null) {
				return;
			}
			{
				var _g : int = 0, _g1 : Array = nodeData.nodes;
				while(_g < _g1.length) {
					var ch : * = _g1[_g];
					++_g;
					ch.mc.visible = false;
					ch.mc.y = 0;
					this.closeNodeLevel2(ch);
				}
			}
		}
		
		public override function onOpenNode(nodeData : *) : void {
			switch(nodeData.type) {
			case "level1":{
				this.openNodeLevel2(nodeData,1);
			}break;
			case "level2":{
				nodeData.mc.setState(true);
				this.openNodeLevel2(nodeData,1);
			}break;
			}
		}
		
		protected function openNodeLevel2(nodeData : *,level : int) : void {
			if(nodeData.nodes == null) {
				return;
			}
			{
				var _g : int = 0, _g1 : Array = nodeData.nodes;
				while(_g < _g1.length) {
					var ch : * = _g1[_g];
					++_g;
					if(level > 1) {
						if(nodeData.opened) {
							ch.mc.visible = true;
						}
					}
					else {
						ch.mc.visible = true;
					}
					this.openNodeLevel2(ch,level + 1);
				}
			}
		}
		
		public override function onSelectNode(nodeData : *) : void {
			switch(nodeData.type) {
			case "level3":{
				if(this.selectedNode != null) {
					this.selectedNode.mc.unselectNode();
				}
				nodeData.mc.selectNode();
			}break;
			}
		}
		
		public override function onFindNodeBy(nodeData : *,idx : int) : Boolean {
			switch(nodeData.type) {
			case "level3":{
				if(nodeData.data.groupIndex == Main.current_group && nodeData.data.projectIndex == Main.current_project && idx == Main.current_image) {
					return true;
				}
			}break;
			}
			return false;
		}
		
	}
}
