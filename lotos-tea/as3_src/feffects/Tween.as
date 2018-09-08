package feffects {
	import flash.Lib;
	import haxe.Timer;
	import haxe.FastList_feffects_Tween;
	import haxe.FastCell_feffects_Tween;
	import flash.Boot;
	public class Tween {
		public function Tween(init : Number = NaN,end : Number = NaN,dur : int = 0,obj : * = null,prop : String = null,easing : Function = null) : void { if( !flash.Boot.skip_constructor ) {
			this.initVal = init;
			this.endVal = end;
			this.duration = dur;
			this.obj = obj;
			this.prop = prop;
			if(easing != null) this.easingF = easing;
			else if(Reflect.isFunction(obj)) this.easingF = obj;
			else this.easingF = this.easingEquation;
			this.isPlaying = false;
		}}
		
		public var duration : int;
		public var position : int;
		public var reversed : Boolean;
		public var isPlaying : Boolean;
		protected var initVal : Number;
		protected var endVal : Number;
		protected var startTime : int;
		protected var pauseTime : int;
		protected var offsetTime : int;
		protected var reverseTime : int;
		protected var updateFunc : Function;
		protected var endFunc : Function;
		protected var easingF : Function;
		protected var obj : *;
		protected var prop : String;
		public function start() : void {
			if(feffects.Tween.timer != null) timer.stop();
			feffects.Tween.timer = new haxe.Timer(interval);
			this.startTime = flash.Lib._getTimer();
			if(this.duration == 0) this.endTween();
			else AddTween(this);
			this.isPlaying = true;
			this.position = 0;
			this.reverseTime = this.startTime;
			this.reversed = false;
		}
		
		public function pause() : void {
			this.pauseTime = flash.Lib._getTimer();
			setTweenPaused(this);
			this.isPlaying = false;
		}
		
		public function resume() : void {
			this.startTime += flash.Lib._getTimer() - this.pauseTime;
			this.reverseTime += flash.Lib._getTimer() - this.pauseTime;
			setTweenActive(this);
			this.isPlaying = true;
		}
		
		public function seek(ms : int) : void {
			this.offsetTime = ms;
		}
		
		public function reverse() : void {
			this.reversed = !this.reversed;
			if(!this.reversed) this.startTime += (flash.Lib._getTimer() - this.reverseTime) << 1;
			this.reverseTime = flash.Lib._getTimer();
		}
		
		public function stop() : void {
			RemoveTween(this);
			this.isPlaying = false;
		}
		
		protected function doInterval() : void {
			var stamp : int = flash.Lib._getTimer();
			var curTime : int = 0;
			{
				if(this.reversed) curTime = (this.reverseTime << 1) - stamp - this.startTime + this.offsetTime;
				else curTime = stamp - this.startTime + this.offsetTime;
			}
			var curVal : Number = this.getCurVal(curTime);
			if(curTime >= this.duration || curTime <= 0) this.endTween();
			else {
				if(this.updateFunc != null) this.updateFunc(curVal);
				if(this.prop != null) Reflect.setField(this.obj,this.prop,curVal);
			}
			this.position = curTime;
		}
		
		protected function getCurVal(curTime : int) : Number {
			return this.easingF(curTime,this.initVal,this.endVal - this.initVal,this.duration);
		}
		
		protected function endTween() : void {
			RemoveTween(this);
			var val : Number = 0.0;
			if(this.reversed) val = this.initVal;
			else val = this.endVal;
			if(this.updateFunc != null) this.updateFunc(val);
			if(this.endFunc != null) this.endFunc(val);
			if(this.prop != null) Reflect.setField(this.obj,this.prop,val);
		}
		
		public function setTweenHandlers(update : Function,end : Function = null) : void {
			this.updateFunc = update;
			this.endFunc = end;
		}
		
		public function setEasing(easingFunc : Function) : void {
			if(easingFunc != null) this.easingF = easingFunc;
		}
		
		protected function easingEquation(t : Number,b : Number,c : Number,d : Number) : Number {
			return c / 2 * (Math.sin(Math.PI * (t / d - 0.5)) + 1) + b;
		}
		
		static protected var aTweens : haxe.FastList_feffects_Tween = new haxe.FastList_feffects_Tween();
		static protected var aPaused : haxe.FastList_feffects_Tween = new haxe.FastList_feffects_Tween();
		static protected var jsDate : Number = Date["now"]().getTime();
		static protected var interval : int = 10;
		static protected var timer : haxe.Timer;
		static protected function AddTween(tween : feffects.Tween) : void {
			aTweens.add(tween);
			timer.run = feffects.Tween.DispatchTweens;
		}
		
		static protected function RemoveTween(tween : feffects.Tween) : void {
			if(tween == null || feffects.Tween.timer == null) return;
			aTweens.remove(tween);
			if(aTweens.isEmpty() && aPaused.isEmpty()) {
				timer.stop();
				feffects.Tween.timer = null;
			}
		}
		
		static public function getActiveTweens() : haxe.FastList_feffects_Tween {
			return aTweens;
		}
		
		static public function getPausedTweens() : haxe.FastList_feffects_Tween {
			return aPaused;
		}
		
		static protected function setTweenPaused(tween : feffects.Tween) : void {
			if(tween == null || feffects.Tween.timer == null) return;
			aPaused.add(tween);
			aTweens.remove(tween);
		}
		
		static protected function setTweenActive(tween : feffects.Tween) : void {
			if(tween == null || feffects.Tween.timer == null) return;
			aTweens.add(tween);
			aPaused.remove(tween);
		}
		
		static protected function DispatchTweens() : void {
			{
				var _g : haxe.FastCell_feffects_Tween = aTweens.head;
				while(_g != null) {
					var i : feffects.Tween = _g.elt;
					_g = _g.next;
					i.doInterval();
				}
			}
		}
		
	}
}
