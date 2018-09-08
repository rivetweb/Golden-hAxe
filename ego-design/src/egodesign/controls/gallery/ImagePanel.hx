package egodesign.controls.gallery;

import flash.display.MovieClip;
import flash.text.TextField;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Loader;
import flash.net.URLRequest;
import flash.Lib;
import flash.display.Bitmap;

import feffects.Tween;
import feffects.easing.Linear;

import egodesign.Utils;
import egodesign.controls.gallery.ImageThumbs;

class ImagePanel extends MovieClip {

	public var image:MovieClip;
	public var descr:TextField;
	
	private var ldr:Loader;
	
	public function new() {
		super();
		
		Utils.setImagePanel(this);
		
		image = cast(getChildAt(0), MovieClip);
		descr = cast(getChildAt(2), TextField);
		
		////image.visible = false;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event) {
		if (Main.current_project < 0) {
			return;
		}
		
		if (image.numChildren > 1) {
			return;
		}
		
		// get first image data
		var first_img = Utils.getImageXmlData(0);
		
		var url:String = first_img.att.file;
		
		////descr.text = first_img.innerData;
		descr.text = "";
		
		// load image
		ldr = new Loader();
		//ldr.alpha = 0.0;
		//ldr.visible = false;
		var urlReq:URLRequest = new URLRequest(url);
		ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, showFirstImage);
		ldr.load(urlReq);
		////image.visible = false;
		image.addChild(ldr);
	}
	
	private function showFirstImage(e:Event) {
		if (image.numChildren > 1) {
			return;
		}
		
		trace("[image loaded]");
		
		var m:MovieClip = Lib.attach("image_big_i");
		image.width = m.width;
		image.height = m.height;
		////image.visible = true;
		
		//ldr.visible = true;
		//var tween = new Tween(0, 1.0, Main.LARGE_IMAGE_DU, ldr, "alpha", Linear.easeOut);
		//tween.start();
	}
}