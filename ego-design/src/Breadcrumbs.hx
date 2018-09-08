package ;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;

import egodesign.Utils;

class Breadcrumbs extends MovieClip {

	var text:TextField;
	
	public function new() {
		super();
		text = null;
		
		if (Main.current_group >= 0) {
			var m:MovieClip = cast(getChildAt(3), MovieClip);
			text = cast(m.getChildAt(0), TextField);
			text.autoSize = TextFieldAutoSize.LEFT;
			text.text = Utils.getGroupXmlData().node.name.innerData;
			
			if (Main.current_project >= 0)
				init_part();
		}
	}
	
	function init_part() {
		var p:MovieClip = Lib.attach("breadcrumb_part");
		p.x = text.textWidth + 18;
		var br_part:TextField = cast(p.getChildAt(1), TextField);
		br_part.text = Utils.getProjectXmlData(Main.current_project).node.name.innerData;
		addChild(p);
	}
	
}