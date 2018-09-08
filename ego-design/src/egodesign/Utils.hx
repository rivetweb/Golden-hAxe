package egodesign;

import egodesign.controls.tree.TreeScrollbar;
import flash.display.MovieClip;
import haxe.xml.Fast;
import flash.Lib;

import egodesign.controls.gallery.ImagePanel;
import egodesign.controls.gallery.ImageThumbs;

class Utils {

	public static function basename(url:String):String {
		var tmp = url.split("/");
		
		return tmp.pop();
	}
	
	public static function dirname(url:String):String {
		var tmp = url.split("/");
		tmp.pop();
		
		return tmp.join("/");
	}
	
	public static function resetCurrentGroup() {
		Main.current_group = -1;
		Main.current_project = -1;
		Main.current_image = 0;
	}
	
	public static function getGroupXmlData():Fast {
		var i = 0;
		var g:Fast = null;
		for (group in Main.projects.elements) {
			if (i == Main.current_group) {
				g = group;
				break;
			}
			i++;
		}
		
		return g;
	}
	
	public static function getProjectXmlData(index:Int):Fast {
		var i = 0;
		var g:Fast = null;
		for (project in getGroupXmlData().nodes.project) {
			if (i == index) {
				g = project;
				break;
			}
			i++;
		}
		return g;
	}
	
	public static function getImageXmlData(index:Int):Fast {
		var i = 0;
		var g:Fast = null;
		for (img in getProjectXmlData(Main.current_project).node.images.elements) {
			if (i == index) {
				g = img;
				break;
			}
			i++;
		}
		
		return g;
	}
	
	public static function showProjectImage(groupIndex:Int, projectIndex:Int, ?imageIndex:Int = 0) {
		var oldProjectIndex = Main.current_project;
		var oldGroupIndex = Main.current_group;
		
		Main.current_group = groupIndex;
		Main.current_project = projectIndex;
		Main.current_image = imageIndex;
		
		if (oldProjectIndex != projectIndex || oldGroupIndex != groupIndex) {
			// change project and load project images
			Main.sound_click1.play();
			Lib.current.gotoAndPlay(1, "projects_2");
		}
		else {
			// change image view
			var thumbsPanel:ImageThumbs = Utils.getThumbsPanel();
			thumbsPanel.setImage(Main.current_image);
		}
	}
	
	public static function getTreeProjects() {
		return Main.projectsTree;
	}
	
	public static function setImagePanel(content:ImagePanel) {
		Main.imagePanel = content;
	}
	
	public static function getImagePanel():ImagePanel {
		return Main.imagePanel;
	}
	
	public static function setThumbsPanel(imageThumbs:ImageThumbs) {
		Main.thumbsPanel = imageThumbs;
	}
	
	public static function getThumbsPanel():ImageThumbs {
		return Main.thumbsPanel;
	}
	
	public static function setCurrentImageIndex(idx:Int) {
		Main.current_image = idx;
	}
		
	public static function setSelectedNode() {
		var treeProjects = Utils.getTreeProjects();
		if (treeProjects.getScrollbar() == null) {
			return;
		}
		
		var res = treeProjects.findNodeBy();
		if (res != null) {
			var projectNode = treeProjects.getParent(res);
			var groupNode = treeProjects.getParent(projectNode);
			
			treeProjects.openNode(groupNode);
			treeProjects.openNode(projectNode);
			treeProjects.setSelectedNode(res);
		}
	}
}