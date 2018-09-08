package  {
	import flash.display.MovieClip;
	import flash.Lib;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class Main {
		static public var DX : int = 10;
		static public var DELAY : int = 30;
		static public var DELAY_SCROLL_INIT : int = 3000;
		static public var SCROLLER_DURATION : int = 5000;
		static public var scene_names : Array = ["марка_FS-появление","марка_Марсель-появление","марка_FemRich-появление"];
		static public function main() : void {
			var itemsScroller : ItemsScroller = new ItemsScroller();
			var infinitScroller : InfinitScroller = null;
			flash.Lib.current.addEventListener(flash.events.Event.ADDED,function(e : flash.events.Event) : void {
				if(e.target.name == "product1" || e.target.name == "product2" || e.target.name == "product3") {
					itemsScroller.initMouseCheck(function() : flash.display.MovieClip {
						var $r : flash.display.MovieClip;
						var tmp : * = e.target;
						$r = (Std._is(tmp,flash.display.MovieClip)?tmp:function() : * {
							var $r2 : *;
							throw "Class cast error";
							return $r2;
						}());
						return $r;
					}());
				}
				else if(e.target.name == "product4") {
					var m : flash.display.MovieClip = function() : flash.display.MovieClip {
						var $r3 : flash.display.MovieClip;
						var tmp2 : * = e.target;
						$r3 = (Std._is(tmp2,flash.display.MovieClip)?tmp2:function() : * {
							var $r4 : *;
							throw "Class cast error";
							return $r4;
						}());
						return $r3;
					}();
					var items : Array = [];
					{
						var _g1 : int = 0, _g : int = m.numChildren;
						while(_g1 < _g) {
							var i : int = _g1++;
							if(m.getChildAt(i).toString().indexOf("tpanel") >= 0) {
								items.push(function() : flash.display.MovieClip {
									var $r5 : flash.display.MovieClip;
									var tmp3 : flash.display.DisplayObject = m.getChildAt(i);
									$r5 = (Std._is(tmp3,flash.display.MovieClip)?tmp3:function() : flash.display.DisplayObject {
										var $r6 : flash.display.DisplayObject;
										throw "Class cast error";
										return $r6;
									}());
									return $r5;
								}());
							}
						}
					}
					infinitScroller = new InfinitScroller(m,items);
					infinitScroller.show();
				}
			});
			flash.Lib.current.addEventListener(flash.events.Event.REMOVED,function(e : flash.events.Event) : void {
				if(e.target.name == "product1" || e.target.name == "product2" || e.target.name == "product3") {
					itemsScroller.cleanMouseCheck();
				}
				else if(e.target.name == "product4") null;
			});
		}
		
	}
}
