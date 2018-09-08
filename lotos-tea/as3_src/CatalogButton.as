package  {
	import flash.Lib;
	import flash.net.URLRequest;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class CatalogButton extends flash.display.SimpleButton {
		public function CatalogButton() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.addEventListener(flash.events.MouseEvent.CLICK,function(e : flash.events.MouseEvent) : void {
				var s : String = e.target.name;
				s = StringTools.replace(s,"bcat_","");
				var url : String = "http://lotos-tea.ru/cat_group.php?id=";
				var u : flash.net.URLRequest = new flash.net.URLRequest(url + s);
				flash.Lib.getURL(u);
			});
		}}
		
	}
}
