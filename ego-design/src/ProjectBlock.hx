package ;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.Timer;

import feffects.Tween;
import feffects.easing.Linear;

import egodesign.Utils;

class ProjectBlock extends MovieClip {

	var title:TextField;
	var descr:TextField;
	var bleft:SimpleButton;
	var bright:SimpleButton;
	
	var items:Array<MovieClip>;
	var view_index:Int;
	var view_size:Int;
	
	var x_start:Float;
		
	public function new() {
		super();
		var me = this;
	
		title = cast(getChildAt(2), TextField);
		descr = cast(getChildAt(3), TextField);
		bleft = cast(getChildAt(1), SimpleButton);
		bright = cast(getChildAt(0), SimpleButton);
		
		items = [];
		view_index = 0;
		view_size = 3;
		x_start = -1;
		
		addEventListener(Event.ADDED_TO_STAGE, init_projects);
		
		if (Main.current_group >= 0) {
			title.text = Utils.getGroupXmlData().node.title.innerData;
			
			//effect - title
			title.alpha = 0;
			Timer.delay(
				function() {
					var tween = new Tween(
						0.0, 1.0, Main.PROJECTS_TITLE_DU,
						me.title, "alpha", Linear.easeOut);
					tween.start();
				},
				Main.PROJECTS_DELAY_TITLE);
			
			descr.text = Utils.getGroupXmlData().node.description.innerData;
			
			//effect - descr
			descr.alpha = 0;
			Timer.delay(
				function() {
					var tween = new Tween(
						0.0, 1.0, Main.PROJECTS_DESCR_DU,
						me.descr, "alpha", Linear.easeOut);
					tween.start();
				},
				Main.PROJECTS_DELAY_DESCR);
		}
	}
	
	function init_projects(e:Event) {
		var projects_block = e.target;
		
		if (x_start < 0)
			x_start = ProjectPanel.x_default;
		
		var x:Float = ProjectPanel.x_default;
		var project_index = 0;
		for (project in Utils.getGroupXmlData().nodes.project) {
			var but:MovieClip = Lib.attach("project_panel");
			but.name = "projectpanel_" + Main.current_group + "_" + project_index;
			but.x = x;
			but.y = ProjectPanel.y_default;
			x += but.width;
			but.project_index = project_index;
			projects_block.addChild(but);
			items.push(but);
						
			//effect - project_panel
			if(project_index < view_size){
				but.alpha = 0;
				Timer.delay(
					function() {
						var tween = new Tween(
							0.0, 1.0, Main.PROJECTS_PANEL_DU,
							but, "alpha", Linear.easeOut);
						tween.start();
					},
					Main.PROJECTS_DELAY_PANEL0 + project_index * Main.PROJECTS_DELAY_PANEL);
			}
			project_index++;
		}
		
		show();
		
		bleft.addEventListener(MouseEvent.CLICK, left_click);
		bright.addEventListener(MouseEvent.CLICK, right_click);
	}
	
	function check_nav() {
		bleft.visible = view_index > 0;
		bright.visible = view_index + view_size < items.length;
	}
	
	function show() {
		check_nav();
		
		var x:Float = x_start;
		var m:Int = view_index + view_size;
		if (m > items.length)
			m = items.length;
		for (i in view_index...m) {
			items[i].x = x;
			items[i].visible = true;
			x += items[0].width;
		}
	}
	
	function left_click(e:MouseEvent) {
		Main.sound_click1.play();
		
		if (view_index <= 0)
			return;
		view_index--;
		for (i in items)
			i.visible = false;
		show();
	}
	
	function right_click(e:MouseEvent) {
		Main.sound_click1.play();
		
		if (view_index >= items.length - view_size)
			return;
		view_index++;
		for (i in items)
			i.visible = false;
		show();
	}
}