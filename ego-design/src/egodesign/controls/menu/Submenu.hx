package egodesign.controls.menu;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.Lib;
import flash.events.Event;
import flash.events.EventPhase;
import flash.display.SimpleButton;
import haxe.Timer;
import haxe.xml.Fast;
import Subitems;

import feffects.Tween;
import feffects.easing.Linear;

import egodesign.Utils;

class Submenu {
	
	public var items:Array<MovieClip>;
	public var items_active:Array<MovieClip>;
	public var active_item:MovieClip;
	
	var container:MovieClip;
	var is_opened:Bool;
	var xml_data:Fast;
	var mask_menu:MovieClip;
	
	var project_item_color:UInt;
	
	public var on_menu:Bool;
		
	public function new(data:Fast) {
		is_opened = false;
		items = [];
		items_active = [];
		xml_data = data;
		active_item = null;
		container = null;
		on_menu = true;
	}
	
	function rearrange(idx:Int) {
		var y = items[0].y;
		for (i in items) {
			i.y = y;
			y += i.height;
		}
	}
	
	public function show(obj:SimpleButton) {
		if (is_opened)
			return;
		is_opened = true;
		
		if(Main.btn_projects != null)
			Main.btn_projects.set_active_state();
		
		container = new MovieClip();
		container.name = "submenu_container";
		Lib.current.addChild(container);
		container.x = obj.x;
		container.y = obj.y + obj.height - 6;
		mask_menu = Lib.attach("mask_main_menu");
		mask_menu.x = container.x;
		mask_menu.y = container.y;
		Lib.current.addChild(mask_menu);
		container.mask = mask_menu;
				
		if (items.length == 0)
			init(obj);
		else
			for (b in items)
				b.visible = true;
	}
	
	public function hide() {
		if(Main.btn_projects != null)
			Main.btn_projects.set_default_state();
		
		is_opened = false;
		for (b in items){
			b.visible = false;
			//Lib.current.removeChild(b);
			container.removeChild(b);
		}
		items = [];
		for (b in items_active){
			b.visible = false;
			//Lib.current.removeChild(b);
			container.removeChild(b);
		}
		items_active = [];
		active_item = null;
		
		if (container != null) {
			//container.removeEventListener(MouseEvent.ROLL_OUT, menu_mouse_out);
			Lib.current.removeChild(mask_menu);
			Lib.current.removeChild(container);
			container = null;
			mask_menu = null;
		}
	}
	
	public function set_active_item(obj:MovieClip) {
		Main.submenu.set_on_menu(true);
		
		//var unactive_item = null;
		var idx:Int = -1;
		var y:Float = 0;
		//restore last activated item
		if (active_item != null) {
			for (i in 0...items_active.length)
				if (items_active[i].visible == true) {
					idx = i;
					break;
				}
			active_item.visible = false;
			items[idx].visible = true;
			rearrange(idx);
		}
		
		obj.visible = false;
		idx = -1;
		for (i in 0...items.length)
			if (obj == items[i]) {
				idx = i;
				break;
			}
		active_item = items_active[idx];
		active_item.x = obj.x;
		active_item.y = items[0].y + idx * items[0].height + 1;
		y = active_item.y + active_item.height;
		
		var tween = new Tween(
			obj.height, active_item.height, Main.PROJECTS_SUBMENU_DU,
			active_item, "height", Linear.easeOut);
		tween.start();
				
		idx++;
		y -= 1;
		for (i in idx...items.length) {
			items[i].y = y;
			y += items[0].height;
		}
		active_item.visible = true;
	}
	
	function init(obj:SimpleButton) {
		var x:Float = 0;
		var y:Float = 0;
		var menu_height:Float = 0;
		var group_index:Int = 0;
		
		container.addEventListener(MouseEvent.ROLL_OVER, mouse_over);
		
		for (group in xml_data.elements) {
			//init normal state item
			var but:MovieClip = Lib.attach("menu_item");
			but.x = x;
			but.y = y;
			but.label.text = group.node.name.innerData;
			but.bg.gotoAndPlay(1);
			y += but.height;
			menu_height += but.height;
			//Lib.current.addChild(but);
			container.addChild(but);
			items.push(but);
			
			//init active state item
			var but:MovieClip = Lib.attach("menu_listbox");
			but.group_index = group_index;
			but.visible = false;
			but.label.text = group.node.name.innerData;
			but.bg.gotoAndPlay(1);
			//Lib.current.addChild(but);
			container.addChild(but);
			
			//init project listbox in group
			var listbox_item_y:Float = 5;
			var project_index:Int = 0;
			for (project in group.nodes.project) {
				var listbox_item:MovieClip = Lib.attach("listbox_item");
				listbox_item.mouseChildren = false;
				listbox_item.name = "project_" + group_index + "_" + project_index;
				listbox_item.x = 5;
				listbox_item.y = listbox_item_y;
				listbox_item_y += listbox_item.height + 5;
				
				var lb_txt:TextField = cast(listbox_item.getChildAt(0), TextField);
				lb_txt.text = project.node.name.innerData;
				project_item_color = lb_txt.textColor;
				
				listbox_item.addEventListener(MouseEvent.CLICK, listboxItemClick);
				listbox_item.addEventListener(MouseEvent.MOUSE_OVER, listbox_mouse_over);
				listbox_item.addEventListener(MouseEvent.MOUSE_OUT, listbox_mouse_out);
				
				but.items.addChild(listbox_item);
				but.box.height = listbox_item_y + 5;
				project_index++;
			}
			
			items_active.push(but);
			group_index++;
		}
		
		var tween = new Tween(
			container.y - menu_height, container.y + 6, Main.PROJECTS_MENU_DU,
			container, "y", Linear.easeOut);
		tween.start();
	}

	public function listboxItemClick(e:MouseEvent ) {
		// goto selected project
		
		Main.sound_click1.play();
		
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		var a:Array<String> = m.name.split("_");
		
		// set current project
		Main.current_group = Std.parseInt(a[1]);
		Main.current_project = Std.parseInt(a[2]);
		Main.current_image = 0;
		
		Main.submenu.hide();
		
		Utils.setSelectedNode();
		
		Lib.current.gotoAndPlay(1, "projects_2");
	}
	
	public function listbox_mouse_over(e: MouseEvent ) {
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		cast(m.getChildAt(0), TextField).textColor = Main.SUBMENU_ITEMS_COLOR;
	}
	
	public function listbox_mouse_out(e: MouseEvent ) {
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		cast(m.getChildAt(0), TextField).textColor = project_item_color;
	}
	
	function mouse_over(e:MouseEvent) {
		if (container != null) {
			container.addEventListener(MouseEvent.ROLL_OUT, mouse_out);
			Main.submenu.set_on_menu(true);
		}
	}
	
	function mouse_out(e:MouseEvent) {
		if (container != null) {
			container.removeEventListener(MouseEvent.ROLL_OUT, mouse_out);
			Main.submenu.set_on_menu(false);
		}
	}
	
	public function set_on_menu(s:Bool) {
		Main.submenu.on_menu = s;
		if(!s)
			Timer.delay(
				function() {
					if (!Main.submenu.on_menu)
						Main.submenu.hide();
				},
				300);
	}
	
	public function remove_listener() {
		container.removeEventListener(MouseEvent.ROLL_OUT, mouse_out);
	}
	
	public function add_listener() {
		container.addEventListener(MouseEvent.ROLL_OUT, mouse_out);
	}
}