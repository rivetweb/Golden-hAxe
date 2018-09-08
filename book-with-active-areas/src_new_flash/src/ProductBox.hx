package ;

import flash.Lib;
import flash.Mouse;
import flash.MovieClip;
import flash.Button;
import flash.TextField;
import haxe.Timer;
import hxjson2.JSON;
import flash.external.ExternalInterface;

class ProductBox {
	var window:MovieClip;
	var info:Dynamic;
	var props:String;
	var product_info:Dynamic;
	
	var product_id:Int;
	var attr_id:Int;
	var prod_id:Int;
	
	public function new(product_id:Int, info:Dynamic) {
		window = Lib.current.attachMovie("tovar", "tovar",
			Lib.current.getNextHighestDepth());
				
		update({ product_name:"", attribute_name:"", attribute_value:"" });
		
		window._visible = false;
				
		this.info = info;
		this.props = "";
		
		if (info[6] != "") {
			var p = info[6].split(":");
			prod_id = Std.parseInt(p[0]);
			attr_id = Std.parseInt(p[1]);
		}
		getProductInfo(product_id, attr_id, prod_id);
	}
	
	function update(info:Dynamic) {
		cast(window.tovar_name, TextField).text =
			info.product_name;
		cast(window.tovar_name, TextField).wordWrap = true;
		cast(window.tovar_optsia, TextField).text =
			info.attribute_name + "\t" + info.attribute_value;
			//StringTools.replace(props, ":", "\t");
	}
	
	function getProductInfo(product_id:Int, attr_id:Int, prod_id:Int) {
		var me = this;
		
		var req = new haxe.Http(
			"/index.php?option=com_flippingbook&task=get_prodimageinfo" +
				"&product_id=" + product_id +
				"&attr_id=" + attr_id +
				"&prod_id=" + prod_id);
		
		req.onData = function(data) {
			me.product_info = JSON.decode(data);
			me.update(me.product_info);
		};
		
		#if debug
		req.onError = function(data) {
			me.product_info = JSON.decode(
				'{"product_id":"25","product_name":"Cofe au Lait 1 Cofe au Lait 2 Cofe au Lait 3 Cofe au Lait 4 Cofe au Lait 5 Cofe au Lait 6", "attribute_name":"Цвет", "attribute_value":"Зеленый"}');
			me.update(me.product_info);
		};
		#end
		
		req.request(false);
	}
	
	function doRequest() {
		var me = this;

		//TODO check value
		var num:Int = Std.parseInt(
			StringTools.trim(cast(me.window.num, TextField).text));

		//TODO make worked request
		var req = new haxe.Http("/index.php");
		req.setHeader("X-Requested-With",	"XMLHttpRequest");
		/*if (me.props != "") {
			var p = me.props.split(":");
			req.setParameter(p[0]+ me.info[5], p[1]);
		}*/
		req.setParameter("Itemid", "1");
		req.setParameter("adjust_price[]", "");
		req.setParameter("category_id", me.info[4]);
		req.setParameter("func", "cartadd");
		req.setParameter("master_product[]", "");
		req.setParameter("option", "com_virtuemart");
		req.setParameter("page", "shop.cart");
		req.setParameter("prod_id[]",
			me.prod_id != null? Std.string(me.prod_id) : me.info[5]);
		req.setParameter("product_id", me.info[5]);
		req.setParameter("quantity[]",
			StringTools.trim(cast(me.window.num, TextField).text));
		req.setParameter("set_price[]", "");
		
		req.onData = function(data) {
			var s:String = data;
			if (s.indexOf("Success") >= 0) {
				var msgbox = new ProductMsgBox(Main.lastx, Main.lasty);
				msgbox.show();
				
				//update infoblock on webpage
				//ExternalInterface.call("flippingbook_addToCart");
				Lib.getURL("javascript:flippingbook_addToCart()"); //hack
				
				Timer.delay(function() {
					msgbox.close();
				}, 1000);
			}
		};
		
		#if debug
		req.onError = function(data) {
			var msgbox = new ProductMsgBox(Main.lastx, Main.lasty);
			msgbox.show();
		};
		#end
		
		req.request(true);
	}
	
	public function show() {
		var me = this;
		
		//if (Main.modalDlgOpened) return;
		
		if (Main.is_zoom) {
			//window._xscale = 100 * (Main.sx2 / Main.kk);
			//window._yscale = 100 * (Main.sy2 / Main.kk);
			window._xscale = 100 * Main.kk;
			window._yscale = 100 * Main.kk;
		}
		window._visible = true;
		Main.modalDlgOpened = true;
		
		//check X bound
		window._x = Main.lastx = Std.int(
			Lib.current._xmouse + window._width - 5 < Lib.current._width ?
				Lib.current._xmouse : Lib.current._width - window._width - 5);
		if (Main.lastx < 0)
			window._x = Main.lastx = 5;
			
		//check Y bound
		window._y = Main.lasty = Std.int(
			Lib.current._ymouse + window._height - 5 < Lib.current._height ?
				Lib.current._ymouse : Lib.current._height - window._height - 5);
		if (Main.lasty < 0)
			window._y = Main.lasty = 5;
		
		window.bAdd.onRelease = function() {
			me.doRequest();
			me.close();
		};
		
		window.bClose.onRelease = function() {
			me.close();
		};
	}
	
	public function close() {
		Main.modalDlgOpened = false;
		window.removeMovieClip();
	}
	
}