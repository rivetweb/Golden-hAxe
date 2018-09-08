package ;

import flash.display.Graphics;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.FontStyle;
import flash.text.TextRenderer;
import flash.text.CSMSettings;
import flash.text.TextColorType;
import flash.text.AntiAliasType;
import flash.display.MovieClip;
import flash.display.Loader;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.net.URLRequest;

import egodesign.Utils;

class ProjectPanel extends MovieClip {

	public var image:MovieClip;
	public var title:TextField;
	public var descr:TextField;
	
	public static var x_default:Float;
	public static var y_default:Float;
	
	public var project_index:Int;
	
	var bg:MovieClip;
	
	public function new() {
		super();
	
		project_index = -1;
		
		//buttonMode = true;
		//useHandCursor = true;
	
		title = cast(getChildAt(1), TextField);
		descr = cast(getChildAt(2), TextField);
		image = cast(getChildAt(3), MovieClip);
	
		//var format:TextFormat = new TextFormat();
		//format.font = "Myriad Pro";
		//format.

		//title.embedFonts = true;
		//title.antiAliasType = AntiAliasType.ADVANCED;
		//title.defaultTextFormat = format;
				
		//title.sharpness = 1000;
		//title.thickness = 100;
		
		//descr.embedFonts = true;
		//descr.antiAliasType = AntiAliasType.ADVANCED;
		//title.defaultTextFormat = format;
		
		addEventListener(Event.ADDED_TO_STAGE, init);
		
		//var m:MovieClip = Lib.attach("font_text");
		//var t:TextField = cast(m.getChildAt(0), TextField);
		//title.defaultTextFormat = t.getTextFormat();
		
		bg = cast(getChildAt(0), MovieClip);
		
		addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
		addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
		addEventListener(MouseEvent.CLICK, mouse_click);
	}
	
	function mouse_over(e:MouseEvent) {
		bg.gotoAndPlay(2);
	}
	
	function mouse_out(e:MouseEvent) {
		bg.gotoAndPlay(1);
	}
	
	
	function mouse_click(e:MouseEvent) {
		Main.sound_click1.play();
		
		var m:MovieClip = cast(e.currentTarget, MovieClip);
		var a:Array<String> = m.name.split("_");
		Main.current_group = Std.parseInt(a[1]);
		Main.current_project = Std.parseInt(a[2]);
		Main.current_image = 0;
		//Main.submenu.hide();
		Lib.current.gotoAndPlay(1, "projects_2");
	}
	
	function init(e:Event) {
		visible = false;
		x_default = x;
		y_default = y;
		
		if (project_index >= 0) {
			var project = Utils.getProjectXmlData(project_index);
			
			title.text = project.node.name.innerData;
			descr.htmlText = project.node.description.innerData;

			var url:String = "";
			if (project.hasNode.thumb) {
				url = project.node.thumb.att.file;
				//untyped __global__["trace"](url);
				
				var ldr:Loader = new Loader();
				var urlReq:URLRequest = new URLRequest(url);
				ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, resize_thumb);
				ldr.load(urlReq);
				image.visible = false;
				image.addChild(ldr);
			}
			
			/*for (first_img in project.node.images.elements) {
				if (first_img.has.thumb){
					url = first_img.att.thumb;
				}
				else
					url = Main.dirname(first_img.att.file) +
						"/thumbs/" + Main.basename(first_img.att.file);
				break;
			}*/
		}
	}
	
	function resize_thumb(e:Event) {
		var m:MovieClip = Lib.attach("project_thumb");
		image.width = m.width;
		image.height = m.height;
		
		image.getChildAt(1).width = m.width;
		image.getChildAt(1).height = m.height;
		
		image.visible = true;
	}
}