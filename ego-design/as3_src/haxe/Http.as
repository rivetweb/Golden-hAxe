package haxe {
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequestHeader;
	import flash.Boot;
	public class Http {
		public function Http(url : String = null) : void { if( !flash.Boot.skip_constructor ) {
			this.url = url;
			this.headers = new Hash();
			this.params = new Hash();
		}}
		
		public var url : String;
		protected var headers : Hash;
		protected var params : Hash;
		public function setHeader(header : String,value : String) : void {
			this.headers.set(header,value);
		}
		
		public function setParameter(param : String,value : String) : void {
			this.params.set(param,value);
		}
		
		public function request(post : Boolean) : void {
			var me : haxe.Http = this;
			var loader : flash.net.URLLoader = new flash.net.URLLoader();
			loader.addEventListener("complete",function(e : *) : void {
				me.onData(loader.data);
			});
			loader.addEventListener("httpStatus",function(e : flash.events.HTTPStatusEvent) : void {
				if(e.status != 0) me.onStatus(e.status);
			});
			loader.addEventListener("ioError",function(e : flash.events.IOErrorEvent) : void {
				me.onError(e.text);
			});
			loader.addEventListener("securityError",function(e : flash.events.SecurityErrorEvent) : void {
				me.onError(e.text);
			});
			var param : Boolean = false;
			var vars : flash.net.URLVariables = new flash.net.URLVariables();
			{ var $it : * = this.params.keys();
			while( $it.hasNext() ) { var k : String = $it.next();
			{
				param = true;
				Reflect.setField(vars,k,this.params.get(k));
			}
			}}
			var small_url : String = this.url;
			if(param && !post) {
				var k2 : Array = this.url.split("?");
				if(k2.length > 1) {
					small_url = k2.shift();
					vars.decode(k2.join("?"));
				}
			}
			var bug : Array = small_url.split("xxx");
			var request : flash.net.URLRequest = new flash.net.URLRequest(small_url);
			{ var $it2 : * = this.headers.keys();
			while( $it2.hasNext() ) { var k3 : String = $it2.next();
			{
				request.requestHeaders.push(new flash.net.URLRequestHeader(k3,this.headers.get(k3)));
			}
			}}
			request.data = vars;
			request.method = (post?"POST":"GET");
			try {
				loader.load(request);
			}
			catch( e : * ){
				this.onError("Exception: " + Std.string(e));
			}
		}
		
		public var onData : Function = function(data : String) : void {
			null;
		}
		public var onError : Function = function(msg : String) : void {
			null;
		}
		public var onStatus : Function = function(status : int) : void {
			null;
		}
	}
}
