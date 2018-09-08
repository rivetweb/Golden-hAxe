package  {
	import flash.Lib;
	import flash.display.SimpleButton;
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class LogoButton extends flash.display.SimpleButton {
		public function LogoButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,this.item_click);
		}}
		
		protected function item_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			Main.submenu.hide();
			egodesign.Utils.resetCurrentGroup();
			flash.Lib.current.gotoAndPlay(1,"main_page");
		}
		
	}
}
