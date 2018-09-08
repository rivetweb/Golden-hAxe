package ;

import flash.Boot;
import flash.display.MovieClip;
import flash.Lib;
import flash.events.Event;
import flash.display.SimpleButton;

import ProductButton;
import GroupButton;
import SerialButton;
import BackButton;
import CatalogButton;

import ItemsScroller;
import InfinitScroller;

import PanelMark;

class Main {
	public static var DX:Int = 10;
	public static var DELAY:Int = 30;
	public static var DELAY_SCROLL_INIT:Int = 3000;
	
	public static var SCROLLER_DURATION:Int = 5000;

	public static var scene_names:Array<String> = [
		"марка_FS-появление",
		"марка_Марсель-появление",
		"марка_FemRich-появление"
		//"марка_FemRich-появление1"
	];
		
	static function main() {
		var itemsScroller = new ItemsScroller();
		
		var infinitScroller:InfinitScroller = null;
		
		Lib.current.addEventListener(
			Event.ADDED,
			function(e:Event) {
				if (e.target.name == "product1" ||
						e.target.name == "product2" ||
						e.target.name == "product3"){
					itemsScroller.initMouseCheck(cast(e.target, MovieClip));
				}
				else if (e.target.name == "product4") {
					//itemsScroller.initMouseCheck(cast(e.target, MovieClip));
					
					var m:MovieClip = cast(e.target, MovieClip);
					var items:Array<MovieClip> = [];
					for (i in 0...m.numChildren) {
						if (m.getChildAt(i).toString().indexOf("tpanel") >= 0) {
							items.push(cast(m.getChildAt(i), MovieClip));
						}
					}
					infinitScroller = new InfinitScroller(m, items);
					infinitScroller.show();
					//Lib.current.stage.frameRate = FRAME_RATE;
				}
			});
			
		Lib.current.addEventListener(
			Event.REMOVED,
			function(e:Event) {
				if (e.target.name == "product1" ||
						e.target.name == "product2" ||
						e.target.name == "product3"){
					itemsScroller.cleanMouseCheck();
				}
				else if (e.target.name == "product4") {
					//itemsScroller.cleanMouseCheck();
				}
			});
	}
}