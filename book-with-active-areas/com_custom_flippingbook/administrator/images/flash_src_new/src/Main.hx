package ;

import flash.Lib;
import flash.Stage;

class Main {
	//real normal image size 
	//public static var clip_width = 360;	
	//public static var clip_height = 513;
	
	//real large image size 
	//public static var zoom_clip_width = 650;
	//public static var zoom_clip_height = 926;
	
	public static var modalDlgOpened = false;
	
	static var path:String = "/images/flippingbook/";
	static var zoom_prefix = "zoom_";
	
	//public static var sx:Float = 1;
	//public static var sy:Float = 1;
	
	//large / normal 
	public static var sx2:Float = 1;
	public static var sy2:Float = 1;
	
	//for dialog box
	public static var kk:Float = 1;
	
	public static var is_zoom:Bool;
	public static var lastx:Int;
	public static var lasty:Int;
	
	static function main() {
		// check is zoom page or normal
		var url_id = StringTools.replace(
			StringTools.replace(
				Lib.current._url.split("/").pop(),
				".swf", ""), "cid", "");
		is_zoom = false;
		if (url_id.indexOf(zoom_prefix) >= 0) {
			is_zoom = true;
			url_id = StringTools.replace(url_id, zoom_prefix, "");
		}
		
		// request data for generating page
		var req = new haxe.Http(
			"/index.php?option=com_flippingbook&task=get_fullimageinfo&cid=" + url_id);		
		req.onData = function(data) {
			var page = new DynamicPage(path, data);
			page.generate();
		};				
		#if debug
		req.onError = function(msg) {
			var page = new DynamicPage("./",
				'["avon/my-book_001.jpg","avon/my-book_zoom_001.jpg",1.8,1.8,[30,12,165,44,7,25,"Color:Green"],[16,200,96,230,7,25,"Color:Green"]]');
			page.generate();
		};
		#end				
		req.request(false);
	}
}