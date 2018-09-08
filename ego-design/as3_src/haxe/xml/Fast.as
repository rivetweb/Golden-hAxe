package haxe.xml {
	import haxe.xml._Fast.AttribAccess;
	import haxe.xml._Fast.HasNodeAccess;
	import haxe.xml._Fast.NodeListAccess;
	import haxe.xml._Fast.HasAttribAccess;
	import haxe.xml._Fast.NodeAccess;
	import flash.Boot;
	public class Fast {
		public function Fast(x : Xml = null) : void { if( !flash.Boot.skip_constructor ) {
			if(x.nodeType != Xml.Document && x.nodeType != Xml.Element) throw "Invalid nodeType " + x.nodeType;
			this.x = x;
			this.node = new haxe.xml._Fast.NodeAccess(x);
			this.nodes = new haxe.xml._Fast.NodeListAccess(x);
			this.att = new haxe.xml._Fast.AttribAccess(x);
			this.has = new haxe.xml._Fast.HasAttribAccess(x);
			this.hasNode = new haxe.xml._Fast.HasNodeAccess(x);
		}}
		
		public var x : Xml;
		public function get name() : String { return getName(); }
		protected var $name : String;
		public function get innerData() : String { return getInnerData(); }
		protected var $innerData : String;
		public function get innerHTML() : String { return getInnerHTML(); }
		protected var $innerHTML : String;
		public var node : haxe.xml._Fast.NodeAccess;
		public var nodes : haxe.xml._Fast.NodeListAccess;
		public var att : haxe.xml._Fast.AttribAccess;
		public var has : haxe.xml._Fast.HasAttribAccess;
		public var hasNode : haxe.xml._Fast.HasNodeAccess;
		public function get elements() : * { return getElements(); }
		protected var $elements : *;
		public function getName() : String {
			return (this.x.nodeType == Xml.Document?"Document":this.x.getNodeName());
		}
		
		public function getInnerData() : String {
			var it : * = this.x.iterator();
			if(!it.hasNext()) throw this.getName() + " does not have data";
			var v : Xml = it.next();
			if(it.hasNext()) throw this.getName() + " does not only have data";
			if(v.nodeType != Xml.PCData && v.nodeType != Xml.CData) throw this.getName() + " does not have data";
			return v.getNodeValue();
		}
		
		public function getInnerHTML() : String {
			var s : StringBuf = new StringBuf();
			{ var $it : * = this.x.iterator();
			while( $it.hasNext() ) { var x : Xml = $it.next();
			s.add(x.toString());
			}}
			return s.toString();
		}
		
		public function getElements() : * {
			var it : * = this.x.elements();
			return { hasNext : it.hasNext, next : function() : haxe.xml.Fast {
				var x : Xml = it.next();
				if(x == null) return null;
				return new haxe.xml.Fast(x);
			}}
		}
		
	}
}
