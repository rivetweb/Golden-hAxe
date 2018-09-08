package egodesign {
	import egodesign.controls.gallery.ImageThumbs;
	import flash.Lib;
	import egodesign.controls.gallery.ImagePanel;
	import egodesign.controls.tree.TreeProjects;
	import haxe.xml.Fast;
	public class Utils {
		static public function basename(url : String) : String {
			var tmp : Array = url.split("/");
			return tmp.pop();
		}
		
		static public function dirname(url : String) : String {
			var tmp : Array = url.split("/");
			tmp.pop();
			return tmp.join("/");
		}
		
		static public function resetCurrentGroup() : void {
			Main.current_group = -1;
			Main.current_project = -1;
			Main.current_image = 0;
		}
		
		static public function getGroupXmlData() : haxe.xml.Fast {
			var i : int = 0;
			var g : haxe.xml.Fast = null;
			{ var $it : * = Main.projects.getElements();
			while( $it.hasNext() ) { var group : haxe.xml.Fast = $it.next();
			{
				if(i == Main.current_group) {
					g = group;
					break;
				}
				i++;
			}
			}}
			return g;
		}
		
		static public function getProjectXmlData(index : int) : haxe.xml.Fast {
			var i : int = 0;
			var g : haxe.xml.Fast = null;
			{ var $it : * = getGroupXmlData().nodes.resolve("project").iterator();
			while( $it.hasNext() ) { var project : haxe.xml.Fast = $it.next();
			{
				if(i == index) {
					g = project;
					break;
				}
				i++;
			}
			}}
			return g;
		}
		
		static public function getImageXmlData(index : int) : haxe.xml.Fast {
			var i : int = 0;
			var g : haxe.xml.Fast = null;
			{ var $it : * = getProjectXmlData(Main.current_project).node.resolve("images").getElements();
			while( $it.hasNext() ) { var img : haxe.xml.Fast = $it.next();
			{
				if(i == index) {
					g = img;
					break;
				}
				i++;
			}
			}}
			return g;
		}
		
		static public function showProjectImage(groupIndex : int,projectIndex : int,imageIndex : int = 0) : void {
			var oldProjectIndex : int = Main.current_project;
			var oldGroupIndex : int = Main.current_group;
			Main.current_group = groupIndex;
			Main.current_project = projectIndex;
			Main.current_image = imageIndex;
			if(oldProjectIndex != projectIndex || oldGroupIndex != groupIndex) {
				Main.sound_click1.play();
				flash.Lib.current.gotoAndPlay(1,"projects_2");
			}
			else {
				var thumbsPanel : egodesign.controls.gallery.ImageThumbs = getThumbsPanel();
				thumbsPanel.setImage(Main.current_image);
			}
		}
		
		static public function getTreeProjects() : egodesign.controls.tree.TreeProjects {
			return Main.projectsTree;
		}
		
		static public function setImagePanel(content : egodesign.controls.gallery.ImagePanel) : void {
			Main.imagePanel = content;
		}
		
		static public function getImagePanel() : egodesign.controls.gallery.ImagePanel {
			return Main.imagePanel;
		}
		
		static public function setThumbsPanel(imageThumbs : egodesign.controls.gallery.ImageThumbs) : void {
			Main.thumbsPanel = imageThumbs;
		}
		
		static public function getThumbsPanel() : egodesign.controls.gallery.ImageThumbs {
			return Main.thumbsPanel;
		}
		
		static public function setCurrentImageIndex(idx : int) : void {
			Main.current_image = idx;
		}
		
		static public function setSelectedNode() : void {
			var treeProjects : egodesign.controls.tree.TreeProjects = getTreeProjects();
			if(treeProjects.getScrollbar() == null) {
				return;
			}
			var res : * = treeProjects.findNodeBy();
			if(res != null) {
				var projectNode : * = treeProjects.getParent(res);
				var groupNode : * = treeProjects.getParent(projectNode);
				treeProjects.openNode(groupNode);
				treeProjects.openNode(projectNode);
				treeProjects.setSelectedNode(res);
			}
		}
		
	}
}
