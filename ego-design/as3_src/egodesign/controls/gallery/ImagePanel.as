package egodesign.controls.gallery {
	import flash.net.URLRequest;
	import flash.display.Loader;
	import haxe.xml.Fast;
	import egodesign.Utils;
	import flash.display.MovieClip;
	import flash.Lib;
	import haxe.Log;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class ImagePanel extends flash.display.MovieClip {
		public function ImagePanel() : void { if( !flash.Boot.skip_constructor ) {
			super();
			egodesign.Utils.setImagePanel(this);
			this.image = (function($this:ImagePanel) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = $this.getChildAt(0);
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImagePanel) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.descr = (function($this:ImagePanel) : flash.text.TextField {
				var $r3 : flash.text.TextField;
				var tmp2 : flash.display.DisplayObject = $this.getChildAt(2);
				$r3 = (Std._is(tmp2,flash.text.TextField)?tmp2:(function($this:ImagePanel) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init);
		}}
		
		public var image : flash.display.MovieClip;
		public var descr : flash.text.TextField;
		protected var ldr : flash.display.Loader;
		protected function init(e : flash.events.Event) : void {
			if(Main.current_project < 0) {
				return;
			}
			if(this.image.numChildren > 1) {
				return;
			}
			var first_img : haxe.xml.Fast = egodesign.Utils.getImageXmlData(0);
			var url : String = first_img.att.resolve("file");
			this.descr.text = "";
			this.ldr = new flash.display.Loader();
			var urlReq : flash.net.URLRequest = new flash.net.URLRequest(url);
			this.ldr.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,this.showFirstImage);
			this.ldr.load(urlReq);
			this.image.addChild(this.ldr);
		}
		
		protected function showFirstImage(e : flash.events.Event) : void {
			if(this.image.numChildren > 1) {
				return;
			}
			haxe.Log.trace("[image loaded]",{ fileName : "ImagePanel.hx", lineNumber : 70, className : "egodesign.controls.gallery.ImagePanel", methodName : "showFirstImage"});
			var m : flash.display.MovieClip = flash.Lib.attach("image_big_i");
			this.image.width = m.width;
			this.image.height = m.height;
		}
		
	}
}
