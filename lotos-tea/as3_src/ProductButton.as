package  {
	import flash.Lib;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class ProductButton extends flash.display.SimpleButton {
		public function ProductButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,function(e : flash.events.MouseEvent) : void {
				switch(e.target.name) {
				case "product1_b_fr":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[2]);
				}break;
				case "product1_b_mr":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[1]);
				}break;
				case "product2_b_fs":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[0]);
				}break;
				case "product2_b_fr":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[2]);
				}break;
				case "product3_b_fs":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[0]);
				}break;
				case "product3_b_mr":{
					flash.Lib.current.gotoAndPlay(1,Main.scene_names[1]);
				}break;
				}
			});
		}}
		
	}
}
