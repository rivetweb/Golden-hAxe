package haxe.xml._Fast {
	import flash.Boot;
	public dynamic class HasNodeAccess {
		public function HasNodeAccess(x : Xml = null) : void { if( !flash.Boot.skip_constructor ) {
			this.__x = x;
		}}
		
		protected var __x : Xml;
		public function resolve(name : String) : Boolean {
			return this.__x.elementsNamed(name).hasNext();
		}
		
	}
}
