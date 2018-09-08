/*
* @author Galaburda Oleg a_[w]
* http://actualwave.com/ 
*
*/

import aw.template.event.broadcaster.Listener;
class aw.template.event.Broadcaster {
	static public function initialize(obj:Object):Void{
		obj[Broadcaster.listName] = new Array();
		obj[Broadcaster.addName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.addListener.apply(Broadcaster, arguments);
		}
		obj[Broadcaster.hasName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.hasListener.apply(Broadcaster, arguments);
		}
		obj[Broadcaster.getName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.getListeners.apply(Broadcaster, arguments);
		}
		obj[Broadcaster.getEventsName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.getListeners.apply(Broadcaster, arguments);
		}
		obj[Broadcaster.removeName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.removeListener.apply(Broadcaster, arguments);
		};
		obj[Broadcaster.broadcastName] = function(){
			arguments.unshift(this[Broadcaster.listName]);
			Broadcaster.broadcastMessage.apply(Broadcaster, arguments);
		};
		_global.ASSetPropFlags(obj, Broadcaster.listName, 3, false);
	}
	//============================= SET / GET
	static public function get listName():String{
		return '__eListeners';
	}
	static public function get addName():String{
		return 'addListener';
	}
	static public function get hasName():String{
		return 'hasListener';
	}
	static public function get getName():String{
		return 'getListeners';
	}
	static public function get getEventsName():String{
		return 'getListenerEvents';
	}
	static public function get removeName():String{
		return 'removeListener';
	}
	static public function get broadcastName():String{
		return 'broadcastMessage';
	}
	//============================= PUBLIC
	static public function addListener(list:Array, obj:Object, event):Void{
		var len:Number = list.length;
		var listenerFinded:Boolean = false;
		var listener:Listener = null;
		for(var i:Number=0; i<len; i++){
			if(list[i].recipient==obj){
				listener = list[i];
				listener.addEvent(event);
				break;
			}
		}
		if(!listener){
			listener = new Listener(obj, event);
			list.push(listener);
		}
		var len:Number = arguments.length;
		for(var i:Number=3; i<len; i++) listener.addEvent(arguments[i]);
	}
	static public function hasListener(list:Array, events):Boolean{
		if(events instanceof Array){
			if(!events.length) return false;
		}else{
			if(!events) return false;
			else events = [events];
		}
		var elen:Number = events.length;
		var llen:Number = list.length;
		var event:String;
		for(var i:Number=0; i<elen; i++){
			var event = events[i];
			for(var j:Number=0; j<llen; j++){
				if(list[j].isExists(event)) return true;
			}
		}
		return false;
	}
	static public function getListeners(list:Array, events):Array{
		var arr:Array = new Array();
		if(events instanceof Array){
			if(!events.length) return arr;
		}else{
			if(!events) return arr;
			else events = [events];
		}
		list = list.concat();
		var elen:Number = events.length;
		var llen:Number = list.length;
		var event:String;
		var listener:Listener;
		for(var i:Number=0; i<elen; i++){
			var event = events[i];
			for(var j:Number=0; j<llen; j++){
				listener = list[j];
				if(listener.isExists(event)){
					arr.push(listener.recipient);
					list.splice(j, 1);
					j--;
					llen--;
				}
			}
		}
		return arr;
	}
	static public function getListenerEvents(list:Array, obj:Object):Array{
		if(obj){
			var len:Number = list.length;
			var listener:Listener;
			for(var j:Number=0; j<len; j++){
				listener = list[j];
				if(listener.recipient==obj){
					return listener.events.concat();
				}
			}
		}
		return [];
	}
	static public function removeListener(list:Array, obj:Object, event):Boolean{
		var len:Number = list.length;
		var listener:Listener = null;
		for(var i:Number=0; i<len; i++){
			if(list[i].recipient==obj){
				listener = list[i];
				if(!event){
					delete list[i];
					list[i].splice(i, 1);
					return true;
				}
				break;
			}
		}
		if(listener){
			var len:Number = arguments.length;
			for(var i:Number=2; i<len; i++) listener.removeEvent(arguments[i]);
			return true;
		}
		return false;
	}
	static public function broadcastMessage(list:Array, event:String):Void{
		var len:Number = list.length;
		arguments.splice(0, 2);
		for(var i:Number=0; i<len; i++){
			list[i].sendEvent(event, arguments);
		}
	}
}