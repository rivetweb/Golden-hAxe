package ;

import flash.Lib;
import flash.MovieClip;
import flash.MovieClipLoader;
import flash.Stage;
import hxjson2.JSON;

class DynamicPage {
	public var path:String;
	public var data:String;
	
	static var dash_style = [10, 10, 5, 5, 2];
	
	public function new(path:String , data:String) {
		this.path = path;
		this.data = data;		
	}

	function makeButton(x:Int, y:Int, w:Int, h:Int, obj:MovieClip, name:String) {
		var alpha = 0;
		var l1_x = dash_style[0];
		var l1_y = dash_style[1];
		var l2_x = dash_style[2];
		var l2_y = dash_style[3];
		var line_width = dash_style[4];
		var tmp = obj.createEmptyMovieClip(
			name, obj.getNextHighestDepth());

		tmp._x = x;
		tmp._y = y;
		//tmp._width = w;
		//tmp._height = h;
		tmp._alpha = alpha;

		tmp.createEmptyMovieClip("buttonBkg", tmp.getNextHighestDepth());
		tmp.buttonBkg._alpha = 0;
		tmp.buttonBkg.beginFill(0xDDDDDD);
		tmp.buttonBkg.lineTo(w, 0);
		tmp.buttonBkg.lineTo(w, h);
		tmp.buttonBkg.lineTo(0, h);
		tmp.buttonBkg.lineTo(0, 0);
		tmp.buttonBkg.endFill();

		tmp.lineStyle(line_width, 0xFD391E, 60, true, "none", "square", "round");
		DrawUtils.dashTo(tmp, 0, 0, w, 0, l1_x, l2_x);
		DrawUtils.dashTo(tmp, w, 0, w, h, l1_y, l2_y);
		DrawUtils.dashTo(tmp, w, h, 0, h, l1_x, l2_x);
		DrawUtils.dashTo(tmp, 0, h, 0, 0, l1_y, l2_y);
		//tmp.lineTo(w, h);
		//tmp.lineTo(0, h);
		//tmp.lineTo(0, 0);

		tmp.onRollOver = function() {
			if (Main.modalDlgOpened) return;
			tmp._alpha = 100;
		};

		tmp.onRollOut = function() {
			tmp._alpha = alpha;
		};

		return tmp;
	}

	public function generate() {
		var me = this;
		
		var info:Array<Dynamic> = JSON.decode(data);
		var image = Main.is_zoom? info[1] : info[0];
		
		//Main.sx = 1;
		//Main.sy = 1;
		// get scale value for zoom image from normal image
		if (Main.is_zoom) {
			Main.sx2 = info[2];
			Main.sy2 = info[3];
			Main.kk = info[4];
		}
		else {
			Main.sx2 = 1;
			Main.sy2 = 1;
			Main.kk = 1;
		}

		var mc_bg:MovieClip = Lib.current.createEmptyMovieClip(
			"mc_background",
			Lib.current.getNextHighestDepth());
		
		/* image loader
		var tmp:Dynamic = { };		
		tmp.onLoadComplete = function(e:MovieClip) {
			Lib.trace("loaded ok");
		};
		
		tmp.onLoadInit = function(e:MovieClip) {
			var w:Float = e._width;
			var h:Float = e._height;
		*/
			
			// get scale value for image from flash swf
			/*			 
			if (Main.is_zoom) {
				Main.sx = Main.zoom_clip_width / w;
				Main.sy = Main.zoom_clip_height / h;
			}
			else {				
				Main.sx = Main.clip_width / w;
				Main.sy = Main.clip_height / h;
			}			
			
			Lib.trace([Main.sx, Main.sy].toString());
			
			mc_bg._xscale = 100 * Main.sx;
			mc_bg._yscale = 100 * Main.sy;
			*/
			
			// generate product buttons
			var kx:Float;
			var ky:Float;
			for (i in 5...info.length) {				
				if (Main.is_zoom) {
					kx = Main.sx2;
					ky = Main.sy2;
				}
				else {
					kx = 1;
					ky = 1;
				}
				
				var x:MovieClip = me.makeButton(
					Std.int(info[i][0] * kx),
					Std.int(info[i][1] * ky),
					Std.int((info[i][2] - info[i][0]) * kx),
					Std.int((info[i][3] - info[i][1]) * ky),
					mc_bg,
					"mc_obj" + i
				);
				x.onRelease = function() {
					if (Main.modalDlgOpened) return;
					var i = Std.parseInt(
						StringTools.replace(x._name, "mc_obj", ""));
					var productbox =
						new ProductBox(info[i][5], info[i]);
					productbox.show();
				};
			}
		/*
		};
		
		var l:MovieClipLoader = new MovieClipLoader();
		l.addListener(tmp);
		l.loadClip(path + image, mc_bg);		
		*/
	}
}
