package  {
	import haxe.xml.Fast;
	import feffects.easing.Linear;
	import flash.events.MouseEvent;
	import egodesign.Utils;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.Lib;
	import feffects.Tween;
	import flash.text.TextField;
	import haxe.Timer;
	import flash.events.Event;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class ProjectBlock extends flash.display.MovieClip {
		public function ProjectBlock() : void { if( !flash.Boot.skip_constructor ) {
			super();
			var me : ProjectBlock = this;
			this.title = (function($this:ProjectBlock) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(2);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:ProjectBlock) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.descr = (function($this:ProjectBlock) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = $this.getChildAt(3);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:ProjectBlock) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.bleft = (function($this:ProjectBlock) : flash.display.SimpleButton {
				var $r5 : flash.display.SimpleButton;
				var tmp3 : flash.display.DisplayObject = $this.getChildAt(1);
				$r5 = (Std._is(tmp3,flash.display.SimpleButton)?tmp3:(function($this:ProjectBlock) : flash.display.DisplayObject {
					var $r6 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r6;
				}($this)));
				return $r5;
			}(this));
			this.bright = (function($this:ProjectBlock) : flash.display.SimpleButton {
				var $r7 : flash.display.SimpleButton;
				var tmp4 : flash.display.DisplayObject = $this.getChildAt(0);
				$r7 = (Std._is(tmp4,flash.display.SimpleButton)?tmp4:(function($this:ProjectBlock) : flash.display.DisplayObject {
					var $r8 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r8;
				}($this)));
				return $r7;
			}(this));
			this.items = [];
			this.view_index = 0;
			this.view_size = 3;
			this.x_start = -1;
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init_projects);
			if(Main.current_group >= 0) {
				this.title.text = egodesign.Utils.getGroupXmlData().node.resolve("title").getInnerData();
				this.title.alpha = 0;
				haxe.Timer.delay(function() : void {
					var tween : feffects.Tween = new feffects.Tween(0.0,1.0,Main.PROJECTS_TITLE_DU,me.title,"alpha",feffects.easing.Linear.easeOut);
					tween.start();
				},Main.PROJECTS_DELAY_TITLE);
				this.descr.text = egodesign.Utils.getGroupXmlData().node.resolve("description").getInnerData();
				this.descr.alpha = 0;
				haxe.Timer.delay(function() : void {
					var tween : feffects.Tween = new feffects.Tween(0.0,1.0,Main.PROJECTS_DESCR_DU,me.descr,"alpha",feffects.easing.Linear.easeOut);
					tween.start();
				},Main.PROJECTS_DELAY_DESCR);
			}
		}}
		
		protected var title : flash.text.TextField;
		protected var descr : flash.text.TextField;
		protected var bleft : flash.display.SimpleButton;
		protected var bright : flash.display.SimpleButton;
		protected var items : Array;
		protected var view_index : int;
		protected var view_size : int;
		protected var x_start : Number;
		protected function init_projects(e : flash.events.Event) : void {
			var projects_block : * = e.target;
			if(this.x_start < 0) this.x_start = ProjectPanel.x_default;
			var x : Number = ProjectPanel.x_default;
			var project_index : int = 0;
			{ var $it : * = egodesign.Utils.getGroupXmlData().nodes.resolve("project").iterator();
			while( $it.hasNext() ) { var project : haxe.xml.Fast = $it.next();
			{
				var but : Array = [flash.Lib.attach("project_panel")];
				but[0].name = "projectpanel_" + Main.current_group + "_" + project_index;
				but[0].x = x;
				but[0].y = ProjectPanel.y_default;
				x += but[0].width;
				but[0].project_index = project_index;
				projects_block.addChild(but[0]);
				this.items.push(but[0]);
				if(project_index < this.view_size) {
					but[0].alpha = 0;
					haxe.Timer.delay(function(but2 : Array) : Function {
						return function() : void {
							var tween : feffects.Tween = new feffects.Tween(0.0,1.0,Main.PROJECTS_PANEL_DU,but2[0],"alpha",feffects.easing.Linear.easeOut);
							tween.start();
						}
					}(but),Main.PROJECTS_DELAY_PANEL0 + project_index * Main.PROJECTS_DELAY_PANEL);
				}
				project_index++;
			}
			}}
			this.show();
			this.bleft.addEventListener(flash.events.MouseEvent.CLICK,this.left_click);
			this.bright.addEventListener(flash.events.MouseEvent.CLICK,this.right_click);
		}
		
		protected function check_nav() : void {
			this.bleft.visible = this.view_index > 0;
			this.bright.visible = this.view_index + this.view_size < this.items.length;
		}
		
		protected function show() : void {
			this.check_nav();
			var x : Number = this.x_start;
			var m : int = this.view_index + this.view_size;
			if(m > this.items.length) m = this.items.length;
			{
				var _g : int = this.view_index;
				while(_g < m) {
					var i : int = _g++;
					this.items[i].x = x;
					this.items[i].visible = true;
					x += this.items[0].width;
				}
			}
		}
		
		protected function left_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			if(this.view_index <= 0) return;
			this.view_index--;
			{
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var i : flash.display.MovieClip = _g1[_g];
					++_g;
					i.visible = false;
				}
			}
			this.show();
		}
		
		protected function right_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			if(this.view_index >= this.items.length - this.view_size) return;
			this.view_index++;
			{
				var _g : int = 0, _g1 : Array = this.items;
				while(_g < _g1.length) {
					var i : flash.display.MovieClip = _g1[_g];
					++_g;
					i.visible = false;
				}
			}
			this.show();
		}
		
	}
}
