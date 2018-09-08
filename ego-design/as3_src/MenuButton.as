package  {
	import egodesign.Utils;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.Lib;
	import flash.Boot;
	import flash.display.DisplayObject;
	public class MenuButton extends flash.display.SimpleButton {
		public function MenuButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.default_state = this.upState;
			this.addEventListener(flash.events.MouseEvent.CLICK,this.item_click);
		}}
		
		protected var default_state : flash.display.DisplayObject;
		protected function item_click(e : flash.events.MouseEvent) : void {
			Main.sound_click1.play();
			Main.submenu.hide();
			egodesign.Utils.resetCurrentGroup();
			var s : String = e.target.name;
			switch(s) {
			case "bmain_about_us":{
				flash.Lib.current.gotoAndPlay(1,"about us");
			}break;
			case "bmain_services":{
				flash.Lib.current.gotoAndPlay(1,"services");
			}break;
			case "bmain_projects":{
				Main.btn_projects = (function($this:MenuButton) : MenuButton {
					var $r : MenuButton;
					var tmp : * = e.target;
					$r = (Std._is(tmp,MenuButton)?tmp:(function($this:MenuButton) : * {
						var $r2 : *;
						throw "Class cast error";
						return $r2;
					}($this)));
					return $r;
				}(this));
				Main.submenu.show((function($this:MenuButton) : flash.display.SimpleButton {
					var $r3 : flash.display.SimpleButton;
					var tmp2 : * = e.target;
					$r3 = (Std._is(tmp2,flash.display.SimpleButton)?tmp2:(function($this:MenuButton) : * {
						var $r4 : *;
						throw "Class cast error";
						return $r4;
					}($this)));
					return $r3;
				}(this)));
			}break;
			case "bmain_contacts":{
				flash.Lib.current.gotoAndPlay(1,"contacts");
			}break;
			}
		}
		
		public function set_active_state() : void {
			this.upState = this.overState;
		}
		
		public function set_default_state() : void {
			this.upState = this.default_state;
		}
		
	}
}
