package  {
	import flash.net.URLRequest;
	import haxe.Firebug;
	import egodesign.controls.gallery.ImagePanel;
	import egodesign.controls.menu.Submenu;
	import haxe.xml.Fast;
	import egodesign.Utils;
	import egodesign.controls.tree.TreeProjects;
	import flash.media.Sound;
	import egodesign.controls.gallery.ImageThumbs;
	import haxe.Http;
	public class Main {
		static public var DX : int = 10;
		static public var DELAY : int = 5;
		static public var DELAY_SCROLL_INIT : int = 100;
		static public var SCROLL_FRAMERATE : int = 200;
		static public var SCROLL_AREA_DX : int = 80;
		static public var PROJECTS_MENU_DU : int = 500;
		static public var PROJECTS_SUBMENU_DU : int = 100;
		static public var LARGE_IMAGE_DU : int = 1000;
		static public var THUMB_IMAGE : Number = 1.1;
		static public var THUMB_IMAGE_DU : int = 100;
		static public var PROJECTS_DELAY_TITLE : int = 0;
		static public var PROJECTS_TITLE_DU : int = 500;
		static public var PROJECTS_DELAY_DESCR : int = 500;
		static public var PROJECTS_DESCR_DU : int = 500;
		static public var PROJECTS_DELAY_PANEL0 : int = 1000;
		static public var PROJECTS_DELAY_PANEL : int = 500;
		static public var PROJECTS_PANEL_DU : int = 500;
		static public var SUBMENU_ITEMS_COLOR : uint = 16777215;
		static public var SCROLL_WHEEL_K : int = 15;
		static public var SCROLL_SPEED : Number = 0.25;
		static public var projects_url : String = "projects.xml";
		static public var projects : haxe.xml.Fast;
		static public var btn_projects : MenuButton;
		static public var current_group : int = -1;
		static public var current_project : int = -1;
		static public var current_image : int = 0;
		static public var sound_click1 : flash.media.Sound;
		static public var submenu : egodesign.controls.menu.Submenu;
		static public var projectsTree : egodesign.controls.tree.TreeProjects;
		static public var imagePanel : egodesign.controls.gallery.ImagePanel;
		static public var thumbsPanel : egodesign.controls.gallery.ImageThumbs;
		static public function main() : void {
			if(haxe.Firebug.detect()) {
				haxe.Firebug.redirectTraces();
			}
			egodesign.Utils.resetCurrentGroup();
			var req : haxe.Http = new haxe.Http(projects_url);
			req.onData = function(data : String) : void {
				Main.projects = new haxe.xml.Fast(Xml.parse(data));
				Main.submenu = new egodesign.controls.menu.Submenu(projects);
				Main.projectsTree = new egodesign.controls.tree.TreeProjects(projects);
			}
			req.request(false);
			Main.sound_click1 = new flash.media.Sound();
			sound_click1.load(new flash.net.URLRequest("click1.mp3"));
		}
		
	}
}
