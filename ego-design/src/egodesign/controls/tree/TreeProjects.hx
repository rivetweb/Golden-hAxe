package egodesign.controls.tree;

import controls.tree.Component;
import flash.events.MouseEvent;
import haxe.xml.Fast;
import flash.Lib;
import flash.text.TextField;

import egodesign.controls.tree.TreeNodeLevel1;
import egodesign.controls.tree.TreeNodeLevel2;
import egodesign.controls.tree.TreeNodeLevel3;

class TreeProjects extends Component {
	
	public function new(xmlData:Fast) {
		super(convertDataFromXml(xmlData));
	}
	
	public function convertDataFromXml(xmlData:Fast):NodeData {
		var result = {
			name: "Root",
			type: "root",
			nodes: [],
			mc: null,
			data: null,
			opened: true
		};
		
		var groupIndex = 0;
		
		for (group in xmlData.elements) {
			// init group data - level1
			var group_data:NodeData = {
				name: group.node.name.innerData,
				type: "level1",
				nodes: [],
				mc: null,
				data: null,
				opened: true
			};
			
			var projectIndex = 0;
			
			for (project in group.nodes.project) {
				// init project data - level2
				var project_data:NodeData = {
					name: project.node.name.innerData,
					type: "level2",
					nodes: [],
					mc: null,
					data: {
						groupIndex: groupIndex
					},
					opened: true
				};
				
				for (img in project.node.images.elements) {
					// init image data - level3
					var image_data:NodeData = {
						name: img.innerData,
						type: "level3",
						nodes: null,
						mc: null,
						data: {
							groupIndex: groupIndex,
							projectIndex: projectIndex
						},
						opened:true
					}
					
					project_data.nodes.push(image_data);
				}
				
				group_data.nodes.push(project_data);
				projectIndex++;
			}

			result.nodes.push(group_data);
			groupIndex++;
		}
		
		return result;
	}
	
	override public function onInitNode(nodeData:NodeData, idx:Int):NodeData {
		var label:TextField;
		
		switch(nodeData.type) {
			case "level1":
				nodeData.opened = false;
				nodeData.mc = Lib.attach("TreeNodeLevel1");
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.visible = true;
				container.addChild(nodeData.mc);
				
			case "level2":
				nodeData.opened = false;
				nodeData.mc = Lib.attach("TreeNodeLevel2");
				nodeData.mc.visible = false;
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.setIndexes(nodeData.data.groupIndex, idx);
				nodeData.mc.setState(nodeData.opened);
				container.addChild(nodeData.mc);

			case "level3":
				nodeData.opened = true;
				nodeData.mc = Lib.attach("TreeNodeLevel3");
				nodeData.mc.visible = false;
				nodeData.mc.setText(nodeData.name);
				nodeData.mc.setIndexes(nodeData.data.groupIndex, nodeData.data.projectIndex, idx);
				container.addChild(nodeData.mc);
		}
		
		return nodeData;
	}
	
	override public function onRenderNode(nodeData:NodeData, idx:Int) {
		if (nodeData.type == "root") {
			return;
		}
		
		if (nodeData.mc.visible) {
			nodeData.mc.y = currentY;
			currentY += nodeData.mc.height;
		}
	}
	
	override public function onCloseNode(nodeData:NodeData) {
		switch(nodeData.type) {
			case "level1":
				closeNodeLevel2(nodeData);
			
			case "level2":
				nodeData.mc.setState(false);
				closeNodeLevel2(nodeData);
		}
	}
	
	private function closeNodeLevel2(nodeData:NodeData) {
		if (nodeData.nodes == null) {
			return;
		}
		
		for (ch in nodeData.nodes) {
			ch.mc.visible = false;
			ch.mc.y = 0;
			
			closeNodeLevel2(ch);
		}
	}
	
	override public function onOpenNode(nodeData:NodeData) {
		switch(nodeData.type) {
			case "level1":
				openNodeLevel2(nodeData, 1);
			
			case "level2":
				nodeData.mc.setState(true);
				openNodeLevel2(nodeData, 1);
		}
	}
	
	private function openNodeLevel2(nodeData:NodeData, level:Int) {
		if (nodeData.nodes == null) {
			return;
		}
		
		for (ch in nodeData.nodes) {
			if (level > 1) {
				if (nodeData.opened) {
					ch.mc.visible = true;
				}
			}
			else {
				ch.mc.visible = true;
			}
			
			openNodeLevel2(ch, level + 1);
		}
	}
	
	override public function onSelectNode(nodeData:NodeData) {
		switch(nodeData.type) {
			case "level3":
				if (selectedNode != null) {
					selectedNode.mc.unselectNode();
				}
				nodeData.mc.selectNode();
		}
	}
	
	override public function onFindNodeBy(nodeData:NodeData, idx:Int):Bool {
		switch(nodeData.type) {
			case "level3":
				if (nodeData.data.groupIndex == Main.current_group &&
						nodeData.data.projectIndex == Main.current_project &&
						idx == Main.current_image) {
					return true;
				}
		}
		
		return false;
	}
	
}