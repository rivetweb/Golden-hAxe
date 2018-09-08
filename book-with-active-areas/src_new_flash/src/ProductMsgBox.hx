package ;

import flash.MovieClip;
import flash.Lib;

class ProductMsgBox {
	var window:MovieClip;
	
	public function new(x:Int, y:Int) {
		window = Lib.current.attachMovie(
			"message", "message",
			Lib.current.getNextHighestDepth());
		window._x = x;
		window._y = y;
		window._visible = false;		
	}
	
	public function show() {
		var me = this;
		
		if (Main.is_zoom) {
			//window._xscale = 100 * (Main.sx2 / Main.kk);
			//window._yscale = 100 * (Main.sy2 / Main.kk);
			window._xscale = 100 * Main.kk;
			window._yscale = 100 * Main.kk;
		}
		window._visible = true;
		Main.modalDlgOpened = true;
		
		window.onRelease = function() {
			me.close();
		}
	}
	
	public function close() {
		if (window == null) return;
		Main.modalDlgOpened = false;
		window.removeMovieClip();
		window = null;
	}
	
}