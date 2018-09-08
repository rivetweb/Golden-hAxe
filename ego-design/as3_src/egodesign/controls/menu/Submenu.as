package egodesign.controls.menu {
	import feffects.easing.Linear;
	import haxe.xml.Fast;
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.text.TextField;
	import feffects.Tween;
	import haxe.Timer;
	import flash.display.DisplayObject;
	import flash.Boot;
	public class Submenu {
		public function Submenu(data : haxe.xml.Fast = null) : void { if( !flash.Boot.skip_constructor ) {
			this.is_opened = false;
			this.items = [];
			this.items_active = [];
			this.xml_data = data;
			this.active_item = null;
			this.container = null;
			this.on_menu = true;
		}}
		
		public var items : Array;
		public var items_active : Array;
		public var active_item : flash.display.MovieClip;
		protected var container : flash.display.MovieClip;
		protected var is_opened : Boolean;
		protected var xml_data : haxe.xml.Fast;
		protected var mask_menu : flash.display.MovieClip;
		protected var project_item_color : uint;
		public var on_menu : Boolean;
		protected function rearrange(idx : int) : void {
			var y : Number = this.items[0].y;
			{
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var i : flash.display.MovieClip = _g1[_g];
					++_g;
					i.y = y;
					y += i.height;
				}
			}
		}
		
		public function show(obj : flash.display.SimpleButton) : void {
			if(this.is_opened) return;
			this.is_opened = true;
			if(Main.btn_projects != null) Main.btn_projects.set_active_state();
			this.container = new flash.display.MovieClip();
			this.container.name = "submenu_container";
			flash.Lib.current.addChild(this.container);
			this.container.x = obj.x;
			this.container.y = obj.y + obj.height - 6;
			this.mask_menu = flash.Lib.attach("mask_main_menu");
			this.mask_menu.x = this.container.x;
			this.mask_menu.y = this.container.y;
			flash.Lib.current.addChild(this.mask_menu);
			this.container.mask = this.mask_menu;
			if(this.items.length == 0) this.init(obj);
			else {
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var b : flash.display.MovieClip = _g1[_g];
					++_g;
					b.visible = true;
				}
			}
		}
		
		public function hide() : void {
			if(Main.btn_projects != null) Main.btn_projects.set_default_state();
			this.is_opened = false;
			{
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var b : flash.display.MovieClip = _g1[_g];
					++_g;
					b.visible = false;
					this.container.removeChild(b);
				}
			}
			this.items = [];
			{
				var _g2 : int = 0, _g12 : Array = this.items_active;
				while(_g2 < _g12.length) {
					var b2 : flash.display.MovieClip = _g12[_g2];
					++_g2;
					b2.visible = false;
					this.container.removeChild(b2);
				}
			}
			this.items_active = [];
			this.active_item = null;
			if(this.container != null) {
				flash.Lib.current.removeChild(this.mask_menu);
				flash.Lib.current.removeChild(this.container);
				this.container = null;
				this.mask_menu = null;
			}
		}
		
		public function set_active_item(obj : flash.display.MovieClip) : void {
			Main.submenu.set_on_menu(true);
			var idx : int = -1;
			var y : Number = 0;
			if(this.active_item != null) {
				{
					var _g1 : int = 0, _g : int = this.items_active.length;
					while(_g1 < _g) {
						var i : int = _g1++;
						if(this.items_active[i].visible == true) {
							idx = i;
							break;
						}
					}
				}
				this.active_item.visible = false;
				this.items[idx].visible = true;
				this.rearrange(idx);
			}
			obj.visible = false;
			idx = -1;
			{
				var _g12 : int = 0, _g2 : int = this.items.length;
				while(_g12 < _g2) {
					var i2 : int = _g12++;
					if(obj == this.items[i2]) {
						idx = i2;
						break;
					}
				}
			}
			this.active_item = this.items_active[idx];
			this.active_item.x = obj.x;
			this.active_item.y = this.items[0].y + idx * this.items[0].height + 1;
			y = this.active_item.y + this.active_item.height;
			var tween : feffects.Tween = new feffects.Tween(obj.height,this.active_item.height,Main.PROJECTS_SUBMENU_DU,this.active_item,"height",feffects.easing.Linear.easeOut);
			tween.start();
			idx++;
			y -= 1;
			{
				var _g13 : int = idx, _g3 : int = this.items.length;
				while(_g13 < _g3) {
					var i3 : int = _g13++;
					this.items[i3].y = y;
					y += this.items[0].height;
				}
			}
			this.active_item.visible = true;
		}
		
		protected function init(obj : flash.display.SimpleButton) : void {
			var x : Number = 0;
			var y : Number = 0;
			var menu_height : Number = 0;
			var group_index : int = 0;
			this.container.addEventListener(flash.events.MouseEvent.ROLL_OVER,this.mouse_over);
			{ var $it : * = this.xml_data.getElements();
			while( $it.hasNext() ) { var group : haxe.xml.Fast = $it.next();
			{
				var but : flash.display.MovieClip = flash.Lib.attach("menu_item");
				but.x = x;
				but.y = y;
				but._label.text = group.node.resolve("name").getInnerData();
				but.bg.gotoAndPlay(1);
				y += but.height;
				menu_height += but.height;
				this.container.addChild(but);
				this.items.push(but);
				var but1 : flash.display.MovieClip = flash.Lib.attach("menu_listbox");
				but1.group_index = group_index;
				but1.visible = false;
				but1._label.text = group.node.resolve("name").getInnerData();
				but1.bg.gotoAndPlay(1);
				this.container.addChild(but1);
				var listbox_item_y : Number = 5;
				var project_index : int = 0;
				{ var $it2 : * = group.nodes.resolve("project").iterator();
				while( $it2.hasNext() ) { var project : haxe.xml.Fast = $it2.next();
				{
					var listbox_item : flash.display.MovieClip = flash.Lib.attach("listbox_item");
					listbox_item.mouseChildren = false;
					listbox_item.name = "project_" + group_index + "_" + project_index;
					listbox_item.x = 5;
					listbox_item.y = listbox_item_y;
					listbox_item_y += listbox_item.height + 5;
					var lb_txt : flash.text.TextField = (function($this:Submenu) : flash.text.TextField {
						var $r : flash.text.TextField;
						var tmp : flash.display.DisplayObject = listbox_item.getChildAt(0);
						$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:Submenu) : flash.display.DisplayObject {
							var $r2 : flash.display.DisplayObject;
							throw "Class cast error";
							return $r2;
						}($this)));
						return $r;
					}(this));
					lb_txt.text = project.node.resolve("name").getInnerData();
					this.project_item_color = lb_txt.textColor;
					listbox_item.addEventListener(flash.events.MouseEvent.CLICK,this.listboxItemClick);
					listbox_item.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.listbox_mouse_over);
					listbox_item.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.listbox_mouse_out);
					but1.items.addChild(listbox_item);
					but1.box.height = listbox_item_y + 5;
					project_index++;
				}
				}}
				this.items_active.push(but1);
				group_index++;
			}
			}}
			var tween : feffects.Tween = new feffects.Tween(this.container.y - menu_height,this.container.y + 6,Main.PROJECTS_MENU_DU,this.container,"y",feffects.easing.Linear.easeOut);
			tween.start();
		}
		
		public function listboxItemClick(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			var m : flash.display.MovieClip = (function($this:Submenu) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Submenu) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			var a : Array = m.name.split("_");
			Main.current_group = Std._parseInt(a[1]);
			Main.current_project = Std._parseInt(a[2]);
			Main.current_image = 0;
			Main.submenu.hide();
			egodesign.Utils.setSelectedNode();
			flash.Lib.current.gotoAndPlay(1,"projects_2");
		}
		
		public function listbox_mouse_over(e : flash.events.MouseEvent) : void {
			var m : flash.display.MovieClip = (function($this:Submenu) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Submenu) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			(function($this:Submenu) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = m.getChildAt(0);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:Submenu) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this)).textColor = Main.SUBMENU_ITEMS_COLOR;
		}
		
		public function listbox_mouse_out(e : flash.events.MouseEvent) : void {
			var m : flash.display.MovieClip = (function($this:Submenu) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:Submenu) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			(function($this:Submenu) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = m.getChildAt(0);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:Submenu) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this)).textColor = this.project_item_color;
		}
		
		protected function mouse_over(e : flash.events.MouseEvent) : void {
			if(this.container != null) {
				this.container.addEventListener(flash.events.MouseEvent.ROLL_OUT,this.mouse_out);
				Main.submenu.set_on_menu(true);
			}
		}
		
		protected function mouse_out(e : flash.events.MouseEvent) : void {
			if(this.container != null) {
				this.container.removeEventListener(flash.events.MouseEvent.ROLL_OUT,this.mouse_out);
				Main.submenu.set_on_menu(false);
			}
		}
		
		public function set_on_menu(s : Boolean) : void {
			Main.submenu.on_menu = s;
			if(!s) haxe.Timer.delay(function() : void {
				if(!Main.submenu.on_menu) Main.submenu.hide();
			},300);
		}
		
		public function remove_listener() : void {
			this.container.removeEventListener(flash.events.MouseEvent.ROLL_OUT,this.mouse_out);
		}
		
		public function add_listener() : void {
			this.container.addEventListener(flash.events.MouseEvent.ROLL_OUT,this.mouse_out);
		}
		
	}
}
