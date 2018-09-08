package  {
	import flash.Lib;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class BackButton extends flash.display.SimpleButton {
		public function BackButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,function(e : flash.events.MouseEvent) : void {
				var s : String = e.target.name;
				if(s.indexOf("bbser1_1") == 0) flash.Lib.current.gotoAndPlay(1,"serie");
				else if(s.indexOf("bbser1_2") == 0) flash.Lib.current.gotoAndPlay(6,"serie");
				else if(s.indexOf("bbser1_3") == 0) flash.Lib.current.gotoAndPlay(11,"serie");
				else if(s.indexOf("bbser1_4") == 0) flash.Lib.current.gotoAndPlay(16,"serie");
				else if(s.indexOf("bbser2_1") == 0) flash.Lib.current.gotoAndPlay(21,"serie");
				else if(s.indexOf("bbser2_2") == 0) flash.Lib.current.gotoAndPlay(26,"serie");
				else if(s.indexOf("bbser2_3") == 0) flash.Lib.current.gotoAndPlay(31,"serie");
				else if(s.indexOf("bbser3_1") == 0) flash.Lib.current.gotoAndPlay(36,"serie");
				else if(s.indexOf("bbser3_2") == 0) flash.Lib.current.gotoAndPlay(41,"serie");
				else if(s.indexOf("bbser3_3") == 0) flash.Lib.current.gotoAndPlay(46,"serie");
			});
		}}
		
	}
}
