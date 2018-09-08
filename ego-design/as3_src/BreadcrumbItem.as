package  {
	import flash.Lib;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class BreadcrumbItem extends flash.display.MovieClip {
		public function BreadcrumbItem() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,this.mouse_click);
		}}
		
		protected function mouse_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			if(this.toString().indexOf("brcr_main") >= 0) flash.Lib.current.gotoAndPlay(1,"main_page");
			else if(this.toString().indexOf("brcr_project") >= 0) {
				Main.current_project = -1;
				flash.Lib.current.gotoAndPlay(1,"projects");
			}
		}
		
	}
}
