package  {
	import flash.net.URLRequest;
	import flash.display.Loader;
	import haxe.xml.Fast;
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class ProjectPanel extends flash.display.MovieClip {
		public function ProjectPanel() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.project_index = -1;
			this.title = (function($this:ProjectPanel) : flash.text.TextField {
				var $r : flash.text.TextField;
				var tmp : flash.display.DisplayObject = $this.getChildAt(1);
				$r = (Std._is(tmp,flash.text.TextField)?tmp:(function($this:ProjectPanel) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.descr = (function($this:ProjectPanel) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = $this.getChildAt(2);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:ProjectPanel) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.image = (function($this:ProjectPanel) : flash.display.MovieClip {
				var $r5 : flash.display.MovieClip;
				var tmp3 : flash.display.DisplayObject = $this.getChildAt(3);
				$r5 = (Std._is(tmp3,flash.display.MovieClip)?tmp3:(function($this:ProjectPanel) : flash.display.DisplayObject {
					var $r6 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r6;
				}($this)));
				return $r5;
			}(this));
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init);
			this.bg = (function($this:ProjectPanel) : flash.display.MovieClip {
				var $r7 : flash.display.MovieClip;
				var tmp4 : flash.display.DisplayObject = $this.getChildAt(0);
				$r7 = (Std._is(tmp4,flash.display.MovieClip)?tmp4:(function($this:ProjectPanel) : flash.display.DisplayObject {
					var $r8 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r8;
				}($this)));
				return $r7;
			}(this));
			this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.mouse_over);
			this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.mouse_out);
			this.addEventListener(flash.events.MouseEvent.CLICK,this.mouse_click);
		}}
		
		public var image : flash.display.MovieClip;
		public var title : flash.text.TextField;
		public var descr : flash.text.TextField;
		public var project_index : int;
		protected var bg : flash.display.MovieClip;
		protected function mouse_over(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(2);
		}
		
		protected function mouse_out(e : flash.events.MouseEvent) : void {
			this.bg.gotoAndPlay(1);
		}
		
		protected function mouse_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			var m : flash.display.MovieClip = (function($this:ProjectPanel) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ProjectPanel) : * {
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
			flash.Lib.current.gotoAndPlay(1,"projects_2");
		}
		
		protected function init(e : flash.events.Event) : void {
			this.visible = false;
			ProjectPanel.x_default = this.x;
			ProjectPanel.y_default = this.y;
			if(this.project_index >= 0) {
				var project : haxe.xml.Fast = egodesign.Utils.getProjectXmlData(this.project_index);
				this.title.text = project.node.resolve("name").getInnerData();
				this.descr.htmlText = project.node.resolve("description").getInnerData();
				var url : String = "";
				if(project.hasNode.resolve("thumb")) {
					url = project.node.resolve("thumb").att.resolve("file");
					var ldr : flash.display.Loader = new flash.display.Loader();
					var urlReq : flash.net.URLRequest = new flash.net.URLRequest(url);
					ldr.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,this.resize_thumb);
					ldr.load(urlReq);
					this.image.visible = false;
					this.image.addChild(ldr);
				}
			}
		}
		
		protected function resize_thumb(e : flash.events.Event) : void {
			var m : flash.display.MovieClip = flash.Lib.attach("project_thumb");
			this.image.width = m.width;
			this.image.height = m.height;
			this.image.getChildAt(1).width = m.width;
			this.image.getChildAt(1).height = m.height;
			this.image.visible = true;
		}
		
		static public var x_default : Number;
		static public var y_default : Number;
	}
}
