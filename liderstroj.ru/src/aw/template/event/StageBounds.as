/*
* @author Galaburda Oleg a_[w]
* http://actualwave.com/ 
*
*/

import aw.template.event.Broadcaster;
import aw.template.geom.Geometry;
import flash.geom.Point;
class aw.template.event.StageBounds extends Object{
	static private var __asInit = initialize();
	static private var _initialized:Boolean = false;
	static private var _mousePressed:Boolean = false;
	static private var _mouseIsOut:Boolean = false;
	static private var _watchStageAlign:Boolean = false;
	static private var _borderThickness:Number = 75;
	static private var stageWidth:Number = 0;
	static private var stageHeight:Number = 0;
	static private var _intTime:Number = 90;
	static private var _halign:String;
	static private var _valign:String;
	static private var _ldistance:Number = 0;
	static private var _langle:Number = 0;
	static private var _lspeed:Number = 0;
	static private var _lposx:Number = 0;
	static private var _lposy:Number = 0;
	static private var _lpositionID:Number;
	static private var _mouseDragOutEvent:String = 'onMouseDragOut';
	static private var _mouseMoveOutEvent:String = 'onMouseMoveOut';
	static private var _mouseDragInEvent:String = 'onMouseDragIn';
	static private var _mouseMoveInEvent:String = 'onMouseMoveIn';
	static public function initialize():Void{
		if(!StageBounds._initialized){
			StageBounds.align = Stage.align;
			StageBounds.watchStageAlign = true;
			StageBounds._lspeed = getTimer();
			StageBounds._lposx = _root._xmouse;
			StageBounds._lposy = _root._ymouse;
			Mouse.addListener(StageBounds);
			Stage.addListener(StageBounds);
			StageBounds.onMouseMove();
			StageBounds.onResize();
			StageBounds._initialized = true;
		}
	}
	static public function remove():Void{
		if(StageBounds._initialized){
			StageBounds.align = null;
			Mouse.removeListener(StageBounds);
			Stage.removeListener(StageBounds);
			StageBounds._initialized = false;
			StageBounds.watchStageAlign = false;
			clearInterval(StageBounds._lpositionID);
		}
	}
	static public function isMouseOutOfBounds(x:Number, y:Number):Boolean{
		if(x==undefined) x = StageBounds.getVisibleXCoord();
		if(y==undefined) y = StageBounds.getVisibleYCoord();
		if(x<0 || x>Stage.width || y<0 || y>Stage.height) return true;
		return false;
	}
	static public function isMouseInWorkArea(x:Number, y:Number):Boolean{
		if(x==undefined) x = StageBounds.getVisibleXCoord();
		if(y==undefined) y = StageBounds.getVisibleYCoord();
		if(x<StageBounds._borderThickness || x>StageBounds.stageWidth || y<StageBounds._borderThickness || y>StageBounds.stageHeight) return true;
		return false;
	}
	//=================================== SET / GET
	static public function set align(p:String):Void{
		p = p.substr(0, 2);
		StageBounds.valign = p.substr(0, 1);
		StageBounds.halign = p.substr(1);
	}
	static public function set halign(p:String):Void{
		StageBounds._halign = p.substr(0, 1).toLowerCase();
	}
	static public function get halign():String{
		return StageBounds._halign;
	}
	static public function set valign(p:String):Void{
		StageBounds._valign = p.substr(0, 1).toLowerCase();
	}
	static public function get valign():String{
		return StageBounds._valign;
	}
	static public function set watchStageAlign(p:Boolean):Void{
		if(p){
			Stage[''+'watch']('align', StageBounds.StageAlignWatcher);
			StageBounds._watchStageAlign = true;
		}else{
			Stage[''+'unwatch']('align');
			StageBounds._watchStageAlign = false;
		}
	}
	static public function get watchStageAlign():Boolean{
		return StageBounds._watchStageAlign;
	}
	static public function set borderThickness(p:Number):Void{
		if(p<=0 || isNaN(p)) p = StageBounds.minBorderThickness;
		StageBounds._borderThickness = Number(p);
		StageBounds.stageWidth = Stage.width-StageBounds._borderThickness*2;
		StageBounds.stageHeight = Stage.height-StageBounds._borderThickness*2;
	}
	static public function get initialized():Boolean{
		return StageBounds._initialized;
	}
	static public function get borderThickness():Number{
		return StageBounds._borderThickness;
	}
	static public function set verificationTimeout(p:Number):Void{
		StageBounds._intTime = p;
	}
	static public function get verificationTimeout():Number{
		return StageBounds._intTime;
	}
	static public function get minBorderThickness():Number{
		return 20;
	}
	static public function get lastDistance():Number{
		return StageBounds._ldistance;
	}
	static public function get lastAngle():Number{
		return StageBounds._langle;
	}
	static public function get lastTime():Number{
		return StageBounds._lspeed;
	}
	static public function get lastPoint():Point{
		return new Point(StageBounds._lposx, StageBounds._lposy);
	}
	static public function get MOUSE_DRAG_OUT_EVENT():String{
		return _mouseDragOutEvent;
	}
	static public function get MOUSE_MOVE_OUT_EVENT():String{
		return _mouseMoveOutEvent;
	}
	static public function get MOUSE_DRAG_IN_EVENT():String{
		return _mouseDragInEvent;
	}
	static public function get MOUSE_MOVE_IN_EVENT():String{
		return _mouseMoveInEvent;
	}
	//=================================== PRIVATE
	static private function StageAlignWatcher(prop:String):Void{
		if(prop=='align'){
			StageBounds.align = Stage.align;
		}
	}
	static private function getVisibleXCoord():Number{
		var w:Number = Stage.width;
		var x:Number = _root._xmouse;
		switch(StageBounds._halign){
			case 'r':
				x += w;
			break;
			case 'c':
				x += w/2;
			break;
			default:
			case 'l':
			break;
		}
		return x;
	}
	static private function getVisibleYCoord():Number{
		var h:Number = Stage.height;
		var y:Number = _root._ymouse;
		switch(StageBounds._valign){
			case 'b':
				y += h;
			break;
			case 'c':
				y += h/2;
			break;
			default:
			case 't':
			break;
		}
		return y;
	}
	static private function intervalLastPosition():Boolean{
		clearInterval(StageBounds._lpositionID);
		if(StageBounds._mouseIsOut) return false;
		var point:Point = Geometry.getPointsByDistance(StageBounds._lposx, StageBounds._lposy, StageBounds._ldistance, StageBounds._langle);
		if(StageBounds.isMouseOutOfBounds(point.x, point.y)){
			StageBounds.broadcastMessage(_mouseMoveOutEvent);
			StageBounds._mouseIsOut = true;
		}
		return true;
	}
	static public function refreshMouseData():Void{
		var nx:Number = StageBounds.getVisibleXCoord();
		var ny:Number = StageBounds.getVisibleYCoord();
		StageBounds._lspeed = getTimer()-StageBounds._lspeed;
		StageBounds._ldistance = Geometry.getDistanceByPoints(StageBounds._lposx, StageBounds._lposy, nx, ny);
		StageBounds._langle = Geometry.getAngleByPoints(StageBounds._lposx, StageBounds._lposy, nx, ny);
		StageBounds._lposx = nx;
		StageBounds._lposy = ny;
	}
	//=================================== LISTENERS
	static public function onMouseUp():Void{
		StageBounds._mousePressed = false;
	}
	static public function onMouseDown():Void{
		StageBounds._mousePressed = true;
	}
	static public function onResize():Void{
		StageBounds.borderThickness = StageBounds._borderThickness;
	}
	static public function onMouseMove():Boolean{
		var wp:Boolean = StageBounds.isMouseInWorkArea();
		if(!wp) return false;
		//----------------------------------
		var p:Boolean = StageBounds.isMouseOutOfBounds();
		if(wp && !StageBounds._mouseIsOut){
			StageBounds.refreshMouseData();
			if(p && StageBounds._mousePressed){
				StageBounds.broadcastMessage(_mouseDragOutEvent);
				StageBounds._mouseIsOut = true;
			}else{
				clearInterval(StageBounds._lpositionID);
				StageBounds._lpositionID = setInterval(StageBounds.intervalLastPosition, StageBounds._intTime);
				
			}
		}
		//----------------------------------
		if(!p && StageBounds._mouseIsOut){
			if(StageBounds._mousePressed){
				StageBounds.broadcastMessage(_mouseDragInEvent);
			}else{
				StageBounds.broadcastMessage(_mouseMoveInEvent);
			}
			StageBounds._mouseIsOut = false;
		}
		 return true;
	}
	//========================================== Broadcaster
	static public var __eListeners:Array = new Array();
	static public function addListener(obj:Object, event):Void{
		arguments.unshift(__eListeners);
		Broadcaster.addListener.apply(Broadcaster, arguments);
	}
	public function hasListener(event):Boolean{
		arguments.unshift(__eListeners);
		return Broadcaster.hasListener.apply(Broadcaster, arguments);
	}
	public function getListeners(event):Array{
		arguments.unshift(__eListeners);
		return Broadcaster.getListeners.apply(Broadcaster, arguments);
	}
	public function getListenerEvents(obj:Object):Array{
		arguments.unshift(__eListeners);
		return Broadcaster.getListenerEvents.apply(Broadcaster, arguments);
	}
	static public function removeListener(obj:Object, event):Boolean{
		arguments.unshift(__eListeners);
		return Broadcaster.removeListener.apply(Broadcaster, arguments);
	}
	static public function broadcastMessage(event:String):Void{
		arguments.unshift(__eListeners);
		Broadcaster.broadcastMessage.apply(Broadcaster, arguments);
	}
}