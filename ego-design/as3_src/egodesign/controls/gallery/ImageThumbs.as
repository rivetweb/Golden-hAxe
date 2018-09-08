package egodesign.controls.gallery {
	import egodesign.controls.gallery.ItemsScroller;
	import egodesign.Utils;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import egodesign.controls.gallery.ImagePanel;
	import flash.Boot;
	import feffects.Tween;
	import haxe.Timer;
	import flash.events.MouseEvent;
	import haxe.xml.Fast;
	import haxe.Log;
	import flash.Lib;
	import flash.display.Loader;
	import feffects.easing.Linear;
	import flash.display.SimpleButton;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.BitmapData;
	public class ImageThumbs extends flash.display.MovieClip {
		public function ImageThumbs() : void { if( !flash.Boot.skip_constructor ) {
			super();
			egodesign.Utils.setThumbsPanel(this);
			var img_thumbs_mask : flash.display.MovieClip = flash.Lib.attach("image_thumbs_mask");
			this.container_width = img_thumbs_mask.width;
			{
				var _g1 : int = 0, _g : int = this.numChildren;
				while(_g1 < _g) {
					var i : int = _g1++;
					this.getChildAt(i).visible = false;
				}
			}
			this.bleft = (function($this:ImageThumbs) : flash.display.SimpleButton {
				var $r : flash.display.SimpleButton;
				var tmp : flash.display.DisplayObject = $this.parent.getChildAt(1);
				$r = (Std._is(tmp,flash.display.SimpleButton)?tmp:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			this.bright = (function($this:ImageThumbs) : flash.display.SimpleButton {
				var $r3 : flash.display.SimpleButton;
				var tmp2 : flash.display.DisplayObject = $this.parent.getChildAt(0);
				$r3 = (Std._is(tmp2,flash.display.SimpleButton)?tmp2:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,this.init);
			this.addEventListener(flash.events.Event.REMOVED_FROM_STAGE,this.clean);
		}}
		
		protected var img_width : Number;
		protected var img_height : Number;
		protected var viewIndex : int;
		protected var bleft : flash.display.SimpleButton;
		protected var bright : flash.display.SimpleButton;
		protected var items : Array;
		protected var itemsScroller : egodesign.controls.gallery.ItemsScroller;
		protected var container_width : Number;
		protected var x_left : Number;
		protected var tweenLargeImage : feffects.Tween;
		protected function initImage(slideItem : flash.display.MovieClip,url : String,itemIndex : int) : void {
			var me : egodesign.controls.gallery.ImageThumbs = this;
			var loader : flash.display.Loader = new flash.display.Loader();
			loader.visible = false;
			var urlReq : flash.net.URLRequest = new flash.net.URLRequest(url);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,function(e : flash.events.Event) : void {
				var b : flash.display.Bitmap = function() : flash.display.Bitmap {
					var $r : flash.display.Bitmap;
					var tmp : * = e.target.content;
					$r = (Std._is(tmp,flash.display.Bitmap)?tmp:function() : * {
						var $r2 : *;
						throw "Class cast error";
						return $r2;
					}());
					return $r;
				}();
				b.width = me.img_width;
				b.height = me.img_height;
				if(itemIndex == Main.current_image) {
					haxe.Log.trace("childs:" + loader.numChildren,{ fileName : "ImageThumbs.hx", lineNumber : 88, className : "egodesign.controls.gallery.ImageThumbs", methodName : "initImage"});
					me.show();
				}
			});
			loader.load(urlReq);
			(function($this:ImageThumbs) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = slideItem.getChildAt(0);
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this)).addChild(loader);
		}
		
		protected function initThumbImage(slideItem : flash.display.MovieClip,url : String,itemIndex : int) : void {
			var me : egodesign.controls.gallery.ImageThumbs = this;
			var loader : flash.display.Loader = new flash.display.Loader();
			var urlReq : flash.net.URLRequest = new flash.net.URLRequest(url);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,function(e : flash.events.Event) : void {
				var b : flash.display.Bitmap = function() : flash.display.Bitmap {
					var $r : flash.display.Bitmap;
					var tmp : * = e.target.content;
					$r = (Std._is(tmp,flash.display.Bitmap)?tmp:function() : * {
						var $r2 : *;
						throw "Class cast error";
						return $r2;
					}());
					return $r;
				}();
				b.width = me.img_width;
				b.height = me.img_height;
				var z : flash.display.MovieClip = function() : flash.display.MovieClip {
					var $r3 : flash.display.MovieClip;
					var tmp2 : flash.display.DisplayObject = slideItem.getChildAt(1);
					$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:function() : flash.display.DisplayObject {
						var $r4 : flash.display.DisplayObject;
						throw "Class cast error";
						return $r4;
					}());
					return $r3;
				}();
				var zbitmap : flash.display.Bitmap = new flash.display.Bitmap(b.bitmapData.clone());
				zbitmap.width = me.img_width;
				zbitmap.height = me.img_height;
				z.addChild(zbitmap);
				slideItem.addEventListener(flash.events.MouseEvent.CLICK,me.thumbOnClick);
				haxe.Timer.delay(function() : void {
					me.tweenLargeImage = new feffects.Tween(0.0,1.0,Main.LARGE_IMAGE_DU,slideItem,"alpha",feffects.easing.Linear.easeOut);
					me.tweenLargeImage.start();
					if(itemIndex == Main.current_image) {
						me.moveToView();
					}
				},300);
			});
			loader.load(urlReq);
			(function($this:ImageThumbs) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = slideItem.getChildAt(0);
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this)).addChild(loader);
		}
		
		protected function init(e : flash.events.Event) : void {
			if(Main.current_project >= 0) {
				var me : egodesign.controls.gallery.ImageThumbs = this;
				this.items = [];
				this.x_left = this.x;
				this.itemsScroller = new egodesign.controls.gallery.ItemsScroller(Std._int(this.x),Std._int(this.y),Std._int(this.container_width));
				var project : haxe.xml.Fast = egodesign.Utils.getProjectXmlData(Main.current_project);
				this.viewIndex = Main.current_image;
				var url : String = "";
				var x : Number = 0;
				var i : int = 0;
				{ var $it : * = project.node.resolve("images").getElements();
				while( $it.hasNext() ) { var img : haxe.xml.Fast = $it.next();
				{
					var slideItem : flash.display.MovieClip = flash.Lib.attach("slideshow_item");
					this.img_width = slideItem.width;
					this.img_height = slideItem.height / 2;
					slideItem.alpha = 0.0;
					slideItem.name = "slideshowitem_" + i;
					slideItem.x = x;
					slideItem.addEventListener(flash.events.MouseEvent.MOUSE_OVER,this.thumb_mouse_over);
					slideItem.addEventListener(flash.events.MouseEvent.MOUSE_OUT,this.thumb_mouse_out);
					this.addChild(slideItem);
					x += slideItem.width + 19;
					this.itemsScroller.item_width = slideItem.width;
					this.items.push(slideItem);
					url = img.att.resolve("file");
					var thumb_url : String = "";
					if(img.has.resolve("thumb")) {
						thumb_url = img.att.resolve("thumb");
					}
					else {
						thumb_url = egodesign.Utils.dirname(url) + "/thumbs/" + egodesign.Utils.basename(url);
					}
					this.initImage(slideItem,url,i);
					this.initThumbImage(slideItem,thumb_url,i);
					i++;
				}
				}}
				this.bleft.addEventListener(flash.events.MouseEvent.CLICK,this.left_click);
				this.bright.addEventListener(flash.events.MouseEvent.CLICK,this.right_click);
				if(this.items.length > 5) {
					this.itemsScroller.initMouseCheck(this);
				}
				this.checkNavigationButtons();
				this.items[this.viewIndex].gotoAndPlay(2);
			}
		}
		
		protected function clean(e : flash.events.Event) : void {
			this.itemsScroller.cleanMouseCheck();
		}
		
		public function setImage(imageIndex : int) : void {
			Main.sound_click1.play();
			if(imageIndex < 0 || imageIndex >= this.items.length) {
				return;
			}
			this.items[this.viewIndex].gotoAndPlay(1);
			this.viewIndex = imageIndex;
			this.show();
			this.items[this.viewIndex].gotoAndPlay(2);
			this.moveToView();
		}
		
		protected function thumbOnClick(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			this.items[this.viewIndex].gotoAndPlay(1);
			var a : Array = e.currentTarget.name.split("_");
			this.viewIndex = Std._parseInt(a[1]);
			this.show();
			this.items[this.viewIndex].gotoAndPlay(2);
		}
		
		protected function left_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			if(this.viewIndex <= 0) {
				return;
			}
			this.items[this.viewIndex].gotoAndPlay(1);
			this.viewIndex--;
			this.show();
			this.items[this.viewIndex].gotoAndPlay(2);
			this.moveToView();
		}
		
		protected function right_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			if(this.viewIndex >= this.items.length - 1) {
				return;
			}
			this.items[this.viewIndex].gotoAndPlay(1);
			this.viewIndex++;
			this.show();
			this.items[this.viewIndex].gotoAndPlay(2);
			this.moveToView();
		}
		
		protected function moveToView() : void {
			if(this.x + this.items[this.viewIndex].x < this.x_left) {
				var tx : Number = this.x + this.items[this.viewIndex].x + this.img_width - this.x_left;
				var tween : feffects.Tween = new feffects.Tween(this.x,this.x + this.img_width - tx,Main.THUMB_IMAGE_DU,this,"x",feffects.easing.Linear.easeOut);
				tween.start();
			}
			else if(this.items[this.viewIndex].x - (this.x_left - this.x) + this.img_width > this.container_width) {
				var tx2 : Number = this.x + this.items[this.viewIndex].x + this.img_width - this.x_left - this.container_width;
				var tween2 : feffects.Tween = new feffects.Tween(this.x,this.x - tx2 - 5,Main.THUMB_IMAGE_DU,this,"x",feffects.easing.Linear.easeOut);
				tween2.start();
			}
		}
		
		protected function checkNavigationButtons() : void {
			this.bleft.visible = this.viewIndex > 0;
			this.bright.visible = this.viewIndex < this.items.length - 1;
		}
		
		protected function getImageData() : flash.display.BitmapData {
			var image : flash.display.MovieClip = (function($this:ImageThumbs) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : flash.display.DisplayObject = $this.items[$this.viewIndex].getChildAt(0);
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			if(image.numChildren < 2) {
				return null;
			}
			var ldr : flash.display.Loader = (function($this:ImageThumbs) : flash.display.Loader {
				var $r3 : flash.display.Loader;
				var tmp2 : flash.display.DisplayObject = image.getChildAt(1);
				$r3 = (Std._is(tmp2,flash.display.Loader)?tmp2:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			if(ldr.numChildren < 1) {
				return null;
			}
			var bitmap : flash.display.DisplayObject = ldr.getChildAt(0);
			haxe.Log.trace("get bitmap",{ fileName : "ImageThumbs.hx", lineNumber : 312, className : "egodesign.controls.gallery.ImageThumbs", methodName : "getImageData"});
			return (function($this:ImageThumbs) : flash.display.Bitmap {
				var $r5 : flash.display.Bitmap;
				var tmp3 : flash.display.DisplayObject = bitmap;
				$r5 = (Std._is(tmp3,flash.display.Bitmap)?tmp3:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r6 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r6;
				}($this)));
				return $r5;
			}(this)).bitmapData.clone();
		}
		
		protected function setImageDataForView(imagePanel : egodesign.controls.gallery.ImagePanel,bitmap : flash.display.BitmapData) : Boolean {
			if(bitmap == null) {
				return false;
			}
			haxe.Log.trace(imagePanel.image.numChildren,{ fileName : "ImageThumbs.hx", lineNumber : 322, className : "egodesign.controls.gallery.ImageThumbs", methodName : "setImageDataForView"});
			if(imagePanel.image.numChildren < 2) {
				return false;
			}
			var ldr : flash.display.Loader = (function($this:ImageThumbs) : flash.display.Loader {
				var $r : flash.display.Loader;
				var tmp : flash.display.DisplayObject = imagePanel.image.getChildAt(1);
				$r = (Std._is(tmp,flash.display.Loader)?tmp:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r2 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			haxe.Log.trace(ldr.numChildren,{ fileName : "ImageThumbs.hx", lineNumber : 330, className : "egodesign.controls.gallery.ImageThumbs", methodName : "setImageDataForView"});
			if(ldr.numChildren < 1) {
				return false;
			}
			var img : flash.display.Bitmap = (function($this:ImageThumbs) : flash.display.Bitmap {
				var $r3 : flash.display.Bitmap;
				var tmp2 : flash.display.DisplayObject = ldr.getChildAt(0);
				$r3 = (Std._is(tmp2,flash.display.Bitmap)?tmp2:(function($this:ImageThumbs) : flash.display.DisplayObject {
					var $r4 : flash.display.DisplayObject;
					throw "Class cast error";
					return $r4;
				}($this)));
				return $r3;
			}(this));
			haxe.Log.trace("set bitmap",{ fileName : "ImageThumbs.hx", lineNumber : 338, className : "egodesign.controls.gallery.ImageThumbs", methodName : "setImageDataForView"});
			imagePanel.image.alpha = 0.0;
			img.bitmapData = bitmap;
			return true;
		}
		
		protected function show() : void {
			var me : egodesign.controls.gallery.ImageThumbs = this;
			this.checkNavigationButtons();
			var imagePanel : egodesign.controls.gallery.ImagePanel = egodesign.Utils.getImagePanel();
			var bitmap : flash.display.BitmapData = this.getImageData();
			haxe.Log.trace("getImageData",{ fileName : "ImageThumbs.hx", lineNumber : 362, className : "egodesign.controls.gallery.ImageThumbs", methodName : "show"});
			var res : Boolean = this.setImageDataForView(imagePanel,bitmap);
			haxe.Log.trace("setImageDataForView",{ fileName : "ImageThumbs.hx", lineNumber : 366, className : "egodesign.controls.gallery.ImageThumbs", methodName : "show"});
			imagePanel.descr.text = egodesign.Utils.getImageXmlData(this.viewIndex).getInnerData();
			if(res) {
				this.restartTweenImage(imagePanel);
			}
			egodesign.Utils.setCurrentImageIndex(this.viewIndex);
			egodesign.Utils.setSelectedNode();
			haxe.Log.trace("[/show]",{ fileName : "ImageThumbs.hx", lineNumber : 378, className : "egodesign.controls.gallery.ImageThumbs", methodName : "show"});
		}
		
		protected function restartTweenImage(imagePanel : egodesign.controls.gallery.ImagePanel) : void {
			if(this.tweenLargeImage != null) {
				this.tweenLargeImage.stop();
			}
			this.tweenLargeImage = new feffects.Tween(0.0,1.0,Main.LARGE_IMAGE_DU,imagePanel.image,"alpha",feffects.easing.Linear.easeOut);
			this.tweenLargeImage.setTweenHandlers(this.imageEffectMove,this.imageEffectFinish);
			this.tweenLargeImage.start();
		}
		
		protected function imageEffectMove(e : Number) : void {
			null;
		}
		
		protected function imageEffectFinish(e : Number) : void {
			null;
		}
		
		protected function thumb_mouse_over(e : flash.events.MouseEvent) : void {
			var m : flash.display.MovieClip = (function($this:ImageThumbs) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImageThumbs) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			var tweenX : feffects.Tween = new feffects.Tween(m.scaleX,Main.THUMB_IMAGE,Main.THUMB_IMAGE_DU,m,"scaleX",feffects.easing.Linear.easeOut);
			var tweenY : feffects.Tween = new feffects.Tween(m.scaleY,Main.THUMB_IMAGE,Main.THUMB_IMAGE_DU,m,"scaleY",feffects.easing.Linear.easeOut);
			tweenX.start();
			tweenY.start();
		}
		
		protected function thumb_mouse_out(e : flash.events.MouseEvent) : void {
			var m : flash.display.MovieClip = (function($this:ImageThumbs) : flash.display.MovieClip {
				var $r : flash.display.MovieClip;
				var tmp : * = e.currentTarget;
				$r = (Std._is(tmp,flash.display.MovieClip)?tmp:(function($this:ImageThumbs) : * {
					var $r2 : *;
					throw "Class cast error";
					return $r2;
				}($this)));
				return $r;
			}(this));
			var tweenX : feffects.Tween = new feffects.Tween(m.scaleX,1.0,Main.THUMB_IMAGE_DU,m,"scaleX",feffects.easing.Linear.easeOut);
			var tweenY : feffects.Tween = new feffects.Tween(m.scaleY,1.0,Main.THUMB_IMAGE_DU,m,"scaleY",feffects.easing.Linear.easeOut);
			tweenX.start();
			tweenY.start();
		}
		
		static protected var dx : int = 19;
	}
}
