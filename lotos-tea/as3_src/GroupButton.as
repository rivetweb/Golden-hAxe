package  {
	import flash.Lib;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class GroupButton extends flash.display.SimpleButton {
		public function GroupButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,function(e : flash.events.MouseEvent) : void {
				switch(e.target.name) {
				case "b3_vkus1":{
					flash.Lib.current.gotoAndPlay(1,"serie");
				}break;
				case "b3_ang1":{
					flash.Lib.current.gotoAndPlay(6,"serie");
				}break;
				case "b3_arom1":{
					flash.Lib.current.gotoAndPlay(16,"serie");
				}break;
				case "b3_ch1":{
					flash.Lib.current.gotoAndPlay(11,"serie");
				}break;
				case "b1_modern1":{
					flash.Lib.current.gotoAndPlay(21,"serie");
				}break;
				case "b1_lv1":{
					flash.Lib.current.gotoAndPlay(26,"serie");
				}break;
				case "b1_clas1":{
					flash.Lib.current.gotoAndPlay(31,"serie");
				}break;
				case "b2_cart1":{
					flash.Lib.current.gotoAndPlay(36,"serie");
				}break;
				case "b2_ves1":{
					flash.Lib.current.gotoAndPlay(41,"serie");
				}break;
				case "b2_pak2":{
					flash.Lib.current.gotoAndPlay(46,"serie");
				}break;
				}
			});
		}}
		
	}
}
