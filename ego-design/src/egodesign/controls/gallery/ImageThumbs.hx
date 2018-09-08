package egodesign.controls.gallery;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Loader;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.display.SimpleButton;
import flash.Lib;
import haxe.Timer;

import feffects.Tween;
import feffects.easing.Linear;

import egodesign.Utils;
import egodesign.controls.gallery.ImagePanel;
import egodesign.controls.gallery.ItemsScroller;

class ImageThumbs extends MovieClip {
	var img_width:Float;
	var img_height:Float;
		
	inline static var dx = 19;
	
	private var viewIndex:Int;
	
	var bleft:SimpleButton;
	var bright:SimpleButton;
	
	var items:Array<MovieClip>;
	private var itemsScroller:ItemsScroller;
	
	var container_width:Float;
	var x_left:Float;
	
	//var effect_in_progress:Bool;
	var tweenLargeImage:Tween;
		
	public function new() {
		super();
		//effect_in_progress = false;
		
		Utils.setThumbsPanel(this);
		
		var img_thumbs_mask:MovieClip = Lib.attach("image_thumbs_mask");
		container_width = img_thumbs_mask.width;
		
		for (i in 0...numChildren) {
			getChildAt(i).visible = false;
		}
	
		bleft = cast(parent.getChildAt(1), SimpleButton);
		bright = cast(parent.getChildAt(0), SimpleButton);
		
		addEventListener(Event.ADDED_TO_STAGE, init);
		addEventListener(Event.REMOVED_FROM_STAGE, clean);
		
		//addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
		//addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
	}
	
	private function initImage(slideItem:MovieClip, url:String, itemIndex:Int) {
		var me = this;
		
		// load item image
		var loader:Loader = new Loader();
		loader.visible = false;
		var urlReq:URLRequest = new URLRequest(url);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
			function(e:Event) {
				var b:Bitmap = cast(e.target.content, Bitmap);
				b.width = me.img_width;
				b.height = me.img_height;
				/*
					var z:MovieClip = cast(m.getChildAt(1), MovieClip);
					var zbitmap:Bitmap = new Bitmap(b.bitmapData.clone());
					zbitmap.width = me.img_width;
					zbitmap.height = me.img_height;
					z.addChild(zbitmap);
					m.addEventListener(MouseEvent.CLICK, me.img_click);
				*/
				
				// show image if selected
				if (itemIndex == Main.current_image) {
					trace("childs:" + loader.numChildren);
					
					me.show();
				}
			});
		loader.load(urlReq);
		
		// add image
		cast(slideItem.getChildAt(0), MovieClip).addChild(loader);
	}
	
	private function initThumbImage(slideItem:MovieClip, url:String, itemIndex:Int) {
		var me = this;
		
		// load slider item thumb image
		var loader:Loader = new Loader();
		var urlReq:URLRequest = new URLRequest(url);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
			function(e:Event) {
				var b:Bitmap = cast(e.target.content, Bitmap);
				b.width = me.img_width;
				b.height = me.img_height;
				var z:MovieClip = cast(slideItem.getChildAt(1), MovieClip);
				var zbitmap:Bitmap = new Bitmap(b.bitmapData.clone());
				zbitmap.width = me.img_width;
				zbitmap.height = me.img_height;
				z.addChild(zbitmap);
				slideItem.addEventListener(MouseEvent.CLICK, me.thumbOnClick);
				
				// show slider item
				Timer.delay(function() {
					me.tweenLargeImage = new Tween(0.0, 1.0, Main.LARGE_IMAGE_DU, slideItem, "alpha", Linear.easeOut);
					me.tweenLargeImage.start();
					
					// show image if selected
					if (itemIndex == Main.current_image) {
						me.moveToView();
					}
				}, 300);
			});
		loader.load(urlReq);
		
		// add thumb image
		cast(slideItem.getChildAt(0), MovieClip).addChild(loader);
	}
	
	private function init(e:Event) {
		if (Main.current_project >= 0) {
			var me = this;
			
			items = [];
			x_left = x;
			itemsScroller = new ItemsScroller(Std.int(x), Std.int(y), Std.int(container_width));
			
			var project = Utils.getProjectXmlData(Main.current_project);
			
			// set current image
			viewIndex = Main.current_image;
			
			// init slider items
			var url:String = "";
			var x:Float = 0;
			var i:Int = 0;
			for (img in project.node.images.elements) {
				var slideItem:MovieClip = Lib.attach("slideshow_item");
				
				img_width = slideItem.width;
				img_height = slideItem.height / 2;
				
				slideItem.alpha = 0.0;
				slideItem.name = "slideshowitem_" + i;
				slideItem.x = x;
				
				slideItem.addEventListener(MouseEvent.MOUSE_OVER, thumb_mouse_over);
				slideItem.addEventListener(MouseEvent.MOUSE_OUT, thumb_mouse_out);
						
				addChild(slideItem);
				
				x += slideItem.width + dx;
				
				itemsScroller.item_width = slideItem.width;
				items.push(slideItem);
				
				url = img.att.file;
				var thumb_url:String = "";
				if (img.has.thumb) {
					thumb_url = img.att.thumb;
				}
				else {
					thumb_url = Utils.dirname(url) + "/thumbs/" + Utils.basename(url);
				}
				
				initImage(slideItem, url, i);
				initThumbImage(slideItem, thumb_url, i);
				
				i++;
			}
			
			bleft.addEventListener(MouseEvent.CLICK, left_click);
			bright.addEventListener(MouseEvent.CLICK, right_click);
			
			//init scroller for items length > view area
			if (items.length > 5) {
				//items[items.length - 1].removeEventListener(MouseEvent.MOUSE_OVER, thumb_mouse_over);
				//items[items.length - 1].removeEventListener(MouseEvent.MOUSE_OUT, thumb_mouse_out);
				//items_scroller.container_width = (Main.IMAGE_THUMB_WIDTH + dx) * items.length;
				itemsScroller.initMouseCheck(this);
			}
			
			checkNavigationButtons();
			items[viewIndex].gotoAndPlay(2);
		}
	}
	
	private function clean(e:Event) {
		itemsScroller.cleanMouseCheck();
	}
	
	public function setImage(imageIndex:Int) {
		Main.sound_click1.play();
		
		if (imageIndex < 0 || imageIndex >= items.length) {
			return;
		}

		items[viewIndex].gotoAndPlay(1);
		viewIndex = imageIndex;
		show();
		items[viewIndex].gotoAndPlay(2);
		
		moveToView();
	}
	
	private function thumbOnClick(e:MouseEvent) {
		//if (effect_in_progress)
		//	return;
		
		Main.sound_click1.play();
		
		items[viewIndex].gotoAndPlay(1);
		var a:Array<String> = e.currentTarget.name.split("_");
		viewIndex = Std.parseInt(a[1]);
		//src = cast(e.currentTarget, MovieClip);
		show();
		items[viewIndex].gotoAndPlay(2);
	}
	
	private function left_click(e:MouseEvent) {
		//if (effect_in_progress)
			//return;
			
		Main.sound_click1.play();
		
		if (viewIndex <= 0) {
			return;
		}
			
		items[viewIndex].gotoAndPlay(1);
		viewIndex--;
		show();
		items[viewIndex].gotoAndPlay(2);
		
		moveToView();
	}
	
	private function right_click(e:MouseEvent) {
		//if (effect_in_progress)
			//return;
			
		Main.sound_click1.play();
		
		if (viewIndex >= items.length - 1) {
			return;
		}
			
		items[viewIndex].gotoAndPlay(1);
		viewIndex++;
		show();
		items[viewIndex].gotoAndPlay(2);
		
		moveToView();
	}
	
	private function moveToView() {
		// move thumbs if out bounds
		if (x + items[viewIndex].x < x_left) {
			var tx = x + items[viewIndex].x + img_width - x_left;
			var tween = new Tween(
				x, x + img_width - tx,
				Main.THUMB_IMAGE_DU,
				this, "x", Linear.easeOut);
			tween.start();
		}
		// move thumbs if out bounds
		else if (items[viewIndex].x - (x_left - x) + img_width > container_width) {
			var tx = x + items[viewIndex].x + img_width - x_left - container_width;
			var tween = new Tween(
				x, x - tx - 5,
				Main.THUMB_IMAGE_DU,
				this, "x", Linear.easeOut);
			tween.start();
		}
	}
	
	private function checkNavigationButtons() {
		bleft.visible = viewIndex > 0;
		bright.visible = viewIndex < items.length - 1;
	}
	
	private function getImageData():BitmapData {
		var image:MovieClip = cast(items[viewIndex].getChildAt(0), MovieClip);
		
		if (image.numChildren < 2) {
			return null;
		}
		
		var ldr = cast(image.getChildAt(1), Loader);
		
		if (ldr.numChildren < 1) {
			return null;
		}
		
		var bitmap = ldr.getChildAt(0);
		
		trace("get bitmap");
		
		return cast(bitmap, Bitmap).bitmapData.clone();
	}
	
	private function setImageDataForView(imagePanel:ImagePanel, bitmap:BitmapData):Bool {
		if (bitmap == null) {
			return false;
		}
	
		trace(imagePanel.image.numChildren);
		
		if (imagePanel.image.numChildren < 2) {
			return false;
		}
		
		var ldr = cast(imagePanel.image.getChildAt(1), Loader);
		
		trace(ldr.numChildren);
			
		if (ldr.numChildren < 1) {
			return false;
		}
		
		var img = cast(ldr.getChildAt(0), Bitmap);
		
		trace("set bitmap");
		
		imagePanel.image.alpha = 0.0;
		img.bitmapData = bitmap;
		
		return true;
	}
	
	private function show() {
		var me = this;
		//if (effect_in_progress)
		//	return;
		
		checkNavigationButtons();
		
		//effect_in_progress = true;
		
		var imagePanel = Utils.getImagePanel();
		
		// set image
		
		
		var bitmap = getImageData();
		
		trace("getImageData");
		
		var res = setImageDataForView(imagePanel, bitmap);
		
		trace("setImageDataForView");
		
		// set text
		imagePanel.descr.text = Utils.getImageXmlData(viewIndex).innerData;
		
		if (res) {
			restartTweenImage(imagePanel);
		}
		
		Utils.setCurrentImageIndex(viewIndex);
		Utils.setSelectedNode();
		
		trace("[/show]");
	}
	
	private function restartTweenImage(imagePanel:ImagePanel) {
		if (tweenLargeImage != null) {
			tweenLargeImage.stop();
		}
		
		tweenLargeImage = new Tween(
			0.0, 1.0, Main.LARGE_IMAGE_DU,
			imagePanel.image, "alpha", Linear.easeOut);
		tweenLargeImage.setTweenHandlers(imageEffectMove, imageEffectFinish);
		tweenLargeImage.start();
	}
	
	private function imageEffectMove(e:Float) {
	}
	
	private function imageEffectFinish(e:Float) {
		//effect_in_progress = false;
	}
	
	private function thumb_mouse_over(e:MouseEvent) {
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		
		var tweenX = new Tween(
			m.scaleX, Main.THUMB_IMAGE,
			Main.THUMB_IMAGE_DU,
			m, "scaleX", Linear.easeOut);
		var tweenY = new Tween(
			m.scaleY, Main.THUMB_IMAGE,
			Main.THUMB_IMAGE_DU,
			m, "scaleY", Linear.easeOut);
		tweenX.start();
		tweenY.start();
		
		//m.gotoAndPlay(2);
	}
	
	private function thumb_mouse_out(e:MouseEvent) {
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		
		var tweenX = new Tween(
			m.scaleX, 1.0,
			Main.THUMB_IMAGE_DU,
			m, "scaleX", Linear.easeOut);
		var tweenY = new Tween(
			m.scaleY, 1.0,
			Main.THUMB_IMAGE_DU,
			m, "scaleY", Linear.easeOut);
		tweenX.start();
		tweenY.start();
		
		//m.gotoAndPlay(1);
	}
}