package  {
	import flash.Lib;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class SerialButton extends flash.display.SimpleButton {
		public function SerialButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,function(e : flash.events.MouseEvent) : void {
				switch(e.target.name) {
				case "bser1_1_1":{
					flash.Lib.current.gotoAndPlay(1,"tea");
				}break;
				case "bser1_1_2":{
					flash.Lib.current.gotoAndPlay(1,"pack");
				}break;
				case "bser1_2_1":{
					flash.Lib.current.gotoAndPlay(5,"tea");
				}break;
				case "bser1_2_2":{
					flash.Lib.current.gotoAndPlay(5,"pack");
				}break;
				case "bser1_3_1":{
					flash.Lib.current.gotoAndPlay(9,"tea");
				}break;
				case "bser1_3_2":{
					flash.Lib.current.gotoAndPlay(9,"pack");
				}break;
				case "bser1_4_1":{
					flash.Lib.current.gotoAndPlay(13,"tea");
				}break;
				case "bser1_4_2":{
					flash.Lib.current.gotoAndPlay(13,"pack");
				}break;
				case "bser2_1_1":{
					flash.Lib.current.gotoAndPlay(17,"tea");
				}break;
				case "bser2_1_2":{
					flash.Lib.current.gotoAndPlay(17,"pack");
				}break;
				case "bser2_2_1":{
					flash.Lib.current.gotoAndPlay(21,"tea");
				}break;
				case "bser2_2_2":{
					flash.Lib.current.gotoAndPlay(21,"pack");
				}break;
				case "bser2_3_1":{
					flash.Lib.current.gotoAndPlay(25,"tea");
				}break;
				case "bser2_3_2":{
					flash.Lib.current.gotoAndPlay(25,"pack");
				}break;
				case "bser3_1_1":{
					flash.Lib.current.gotoAndPlay(29,"tea");
				}break;
				case "bser3_1_2":{
					flash.Lib.current.gotoAndPlay(29,"pack");
				}break;
				case "bser3_2_1":{
					flash.Lib.current.gotoAndPlay(33,"tea");
				}break;
				case "bser3_2_2":{
					flash.Lib.current.gotoAndPlay(33,"pack");
				}break;
				case "bser3_3_1":{
					flash.Lib.current.gotoAndPlay(37,"tea");
				}break;
				case "bser3_3_2":{
					flash.Lib.current.gotoAndPlay(37,"pack");
				}break;
				}
			});
		}}
		
	}
}
