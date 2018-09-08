package  {
	import flash.Lib;
	import flash.display.MovieClip;
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class ProjectButton extends flash.display.MovieClip {
		public function ProjectButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.mouseChildren = false;
			this.buttonMode = true;
			this.addEventListener(flash.events.MouseEvent.CLICK,this.item_click);
			this.addEventListener(flash.events.MouseEvent.ROLL_OVER,this.mouse_over);
			this.addEventListener(flash.events.MouseEvent.ROLL_OUT,this.mouse_out);
		}}
		
		protected function item_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			Main.submenu.hide();
			egodesign.Utils.resetCurrentGroup();
			var s : * = e.currentTarget.toString();
			Main.current_group = 0;
			if(s.indexOf("live_interior") >= 0) Main.current_group = 0;
			else if(s.indexOf("publ_interior") >= 0) Main.current_group = 1;
			else if(s.indexOf("other") >= 0) Main.current_group = 2;
			flash.Lib.current.gotoAndPlay(1,"projects");
		}
		
		protected function mouse_over(e : flash.events.MouseEvent) : void {
			this.gotoAndPlay(2);
		}
		
		protected function mouse_out(e : flash.events.MouseEvent) : void {
			this.gotoAndPlay(1);
		}
		
	}
}
