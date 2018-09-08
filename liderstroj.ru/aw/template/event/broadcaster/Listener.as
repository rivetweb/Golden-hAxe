/*
* @author Galaburda Oleg a_[w]
* http://actualwave.com/ 
*
*/

class aw.template.event.broadcaster.Listener{
	private var _item:Object;
	private var _events:Array;
	function Listener(obj:Object, events){
		_item = obj;
		_events = new Array();
		addEvent(events);
	}
	public function addEvent(e):Void{
		if(e instanceof Array){
			var len:Number = e.length;
			for(var i:Number=0; i<len; i++){
				this.addEvent(e[i]);
			}
		}else{
			if(e && !this.isExists(e)){
				this._events.push(e);
			}
		}
	}
	public function removeEvent(e):Void{
		if(e instanceof Array){
			var len:Number = e.length;
			for(var i:Number=0; i<len; i++){
				this.removeEvent(e[i]);
			}
		}else{
			var len:Number = this._events.length;
			for(var i:Number=0; i<len; i++){
				if(this._events[i]===e){
					this._events.splice(i, 1);
					break;
				}
			}
		}
	}
	public function sendEvent(event:String, params:Array):Void{
		if(this.isExists(event) || !this._events.length){
			this._item[event].apply(this._item, params);
		}
	}
	public function isExists(e:String):Boolean{
		var len:Number = this._events.length;
		for(var i:Number=0; i<len; i++){
			if(this._events[i]==e) return true;
		}
		return false;
	}
	//======================== SET / GET
	public function get recipient():Object{
		return this._item;
	}
	public function get events():Array{
		return this._events;
	}
}