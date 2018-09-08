package com.spikything.utils;

import flash.display.Stage;
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
	
/**
 * MouseWheelTrap - stops simultaneous browser/Flash mousewheel scrolling
 * @author Liam O'Donnell
 * @version 1.0
 * @usage Simply call the static method MouseWheelTrap.setup(stage);
 * @see http://www.spikything.com/blog/?s=mousewheeltrap for info/updates
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 * © 2009 spikything.com
 */
class MouseWheelTrap {
	private static inline var JAVASCRIPT = "var browserScrolling;function allowBrowserScroll(value){browserScrolling=value;}function handle(delta){if(!browserScrolling){return false;}return true;}function wheel(event){var delta=0;if(!event){event=window.event;}if(event.wheelDelta){delta=event.wheelDelta/120;if(window.opera){delta=-delta;}}else if(event.detail){delta=-event.detail/3;}if(delta){handle(delta);}if(!browserScrolling){if(event.preventDefault){event.preventDefault();}event.returnValue=false;}}if(window.addEventListener){window.addEventListener('DOMMouseScroll',wheel,false);}window.onmousewheel=document.onmousewheel=wheel;allowBrowserScroll(true);";
	private static inline var JS_METHOD = "allowBrowserScroll";
	
	private static var _browserScrollEnabled:Bool = true;
	private static var _mouseWheelTrapped:Bool = false;
	
	private static inline var INSTANTIATION_ERROR = "Don't instantiate com.spikything.utils.MouseWheelTrap directly. Just call MouseWheelTrap.setup(stage);";
	
	public function new() {
		throw new IllegalOperationError(INSTANTIATION_ERROR);
	}
	
	/// Sets up the Flash and the browser to deal with turning browser scrolling on/off as the mouse cursor enters and leaves the stage (a valid reference to stage is required)
	public static function setup(stage:Stage):Void {
		stage.addEventListener(MouseEvent.MOUSE_MOVE,
			function(e:Event = null):Void {
				allowBrowserScroll(false);
			});
		
		stage.addEventListener(Event.MOUSE_LEAVE,
			function(e:Event = null):Void {
				allowBrowserScroll(true);
			});
	}
	
	private static function allowBrowserScroll(allow:Bool):Void {
		createMouseWheelTrap();
		
		if (allow == _browserScrollEnabled) {
			return;
		}
		_browserScrollEnabled = allow;
		
		if (ExternalInterface.available) {
			ExternalInterface.call(JS_METHOD, _browserScrollEnabled);
			
			return;
		}
	}
	
	private static function createMouseWheelTrap():Void {
		if (_mouseWheelTrapped) {
			return;
		}
		_mouseWheelTrapped = true;
		
		if (ExternalInterface.available) {
			ExternalInterface.call("eval", JAVASCRIPT);
			
			return;
		}
	}
	
}