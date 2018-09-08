package ;

import flash.Boot;
import flash.display.MovieClip;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.SimpleButton;
import haxe.xml.Fast;
import haxe.Http;
import haxe.Firebug;

import flash.text.TextRenderer;
import flash.text.CSMSettings;
import flash.text.FontStyle;
import flash.text.TextColorType;
import flash.text.AntiAliasType;

import flash.net.URLRequest;
import flash.media.Sound;

//import com.spikything.utils.MouseWheelTrap;

import MenuButton;
import GroupButton;
import Subitems;
import ProjectPanel;
import Breadcrumbs;
import BreadcrumbItem;
import ProjectBlock;
import LogoButton;
import ProjectButton;

import egodesign.controls.menu.Submenu;

import egodesign.controls.tree.TreeProjects;
import egodesign.controls.tree.TreeProjectsContainer;
import egodesign.controls.tree.TreeScrollbar;

import egodesign.controls.gallery.ImagePanel;
import egodesign.controls.gallery.ImageThumbs;

import egodesign.Utils;

class Main {
	// DX / DELAY - velocity for scroller
	public static var DX:Int = 10;
	public static var DELAY:Int = 5;
	public static var DELAY_SCROLL_INIT:Int = 100;
	public static var SCROLL_FRAMERATE:Int = 200;
	public static var SCROLL_AREA_DX = 80;
	
	public static var PROJECTS_MENU_DU = 500;
	public static var PROJECTS_SUBMENU_DU = 100;
	public static var LARGE_IMAGE_DU = 1000;
	public static var THUMB_IMAGE = 1.1;
	public static var THUMB_IMAGE_DU = 100;
	
	public static var PROJECTS_DELAY_TITLE = 0;
	public static var PROJECTS_TITLE_DU = 500;
	public static var PROJECTS_DELAY_DESCR = 500;
	public static var PROJECTS_DESCR_DU = 500;
	public static var PROJECTS_DELAY_PANEL0 = 1000;
	public static var PROJECTS_DELAY_PANEL = 500;
	public static var PROJECTS_PANEL_DU = 500;
	
	public static var SUBMENU_ITEMS_COLOR:UInt = 0xFFFFFF;
	//public static var IMAGE_THUMB_WIDTH:Float = 98;
	
	public static var SCROLL_WHEEL_K = 15;
	public static var SCROLL_SPEED = 0.25;
	
	public static var projects_url:String = "projects.xml";
	public static var projects:Fast;
	public static var btn_projects:MenuButton;
	public static var current_group:Int = -1;
	public static var current_project:Int = -1;
	public static var current_image:Int = 0;
	
	public static var sound_click1:Sound;
	
	// projects submenu
	public static var submenu:Submenu;
	
	// customtree for projects
	public static var projectsTree:TreeProjects;
		
	// image panel
	public static var imagePanel:ImagePanel;
	public static var thumbsPanel:ImageThumbs;
	
	static function main() {
		// fix bug for firefox and google chrome
		//MouseWheelTrap.setup(Lib.current.stage);
				
		// set debug trace for Firefox/Firebug
		if (Firebug.detect()) {
			Firebug.redirectTraces();
		}
		
		Utils.resetCurrentGroup();
		
		var req = new haxe.Http(projects_url);
		req.onData = function(data:String) {
			// load project xml file
			Main.projects = new haxe.xml.Fast(Xml.parse(data));
			
			// create submenu
			Main.submenu = new Submenu(Main.projects);
			
			// create projects tree
			Main.projectsTree = new TreeProjects(Main.projects);
		};
		req.request(false);
		
		// attach sound
		sound_click1 = new Sound();
		sound_click1.load(new URLRequest("click1.mp3"));
				
		/*Lib.current.addEventListener(MouseEvent.CLICK,
			function (e:MouseEvent) {
				//if(Main.submenu.check_click(e))
					//Main.submenu.hide();
			});
		*/
	}
}