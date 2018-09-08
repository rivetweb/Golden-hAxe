package haxe {
	import flash.Boot;
	import feffects.Tween;
	public class FastCell_feffects_Tween {
		public function FastCell_feffects_Tween(elt : feffects.Tween = null,next : haxe.FastCell_feffects_Tween = null) : void { if( !flash.Boot.skip_constructor ) {
			this.elt = elt;
			this.next = next;
		}}
		
		public var elt : feffects.Tween;
		public var next : haxe.FastCell_feffects_Tween;
	}
}
