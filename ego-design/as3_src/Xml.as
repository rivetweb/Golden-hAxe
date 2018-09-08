package  {
	public class Xml {
		public function Xml() : void {
			null;
		}
		
		public var nodeType : Object;
		public function get nodeName() : String { return getNodeName(); }
		public function set nodeName( __v : String ) : void { setNodeName(__v); }
		protected var $nodeName : String;
		public function get nodeValue() : String { return getNodeValue(); }
		public function set nodeValue( __v : String ) : void { setNodeValue(__v); }
		protected var $nodeValue : String;
		public function get parent() : Xml { return getParent(); }
		protected var $parent : Xml;
		protected var _nodeName : String;
		protected var _nodeValue : String;
		protected var _attributes : Hash;
		protected var _children : Array;
		protected var _parent : Xml;
		public function getNodeName() : String {
			if(this.nodeType != Element) throw "bad nodeType";
			return this._nodeName;
		}
		
		public function setNodeName(n : String) : String {
			if(this.nodeType != Element) throw "bad nodeType";
			return this._nodeName = n;
		}
		
		public function getNodeValue() : String {
			if(this.nodeType == Element || this.nodeType == Document) throw "bad nodeType";
			return this._nodeValue;
		}
		
		public function setNodeValue(v : String) : String {
			if(this.nodeType == Element || this.nodeType == Document) throw "bad nodeType";
			return this._nodeValue = v;
		}
		
		public function getParent() : Xml {
			return this._parent;
		}
		
		public function get(att : String) : String {
			if(this.nodeType != Element) throw "bad nodeType";
			return this._attributes.get(att);
		}
		
		public function set(att : String,value : String) : void {
			if(this.nodeType != Element) throw "bad nodeType";
			this._attributes.set(att,value);
		}
		
		public function remove(att : String) : void {
			if(this.nodeType != Element) throw "bad nodeType";
			this._attributes.remove(att);
		}
		
		public function exists(att : String) : Boolean {
			if(this.nodeType != Element) throw "bad nodeType";
			return this._attributes.exists(att);
		}
		
		public function attributes() : * {
			if(this.nodeType != Element) throw "bad nodeType";
			return this._attributes.keys();
		}
		
		public function iterator() : * {
			if(this._children == null) throw "bad nodetype";
			var cur : int = 0;
			var x : Array = this._children;
			return { hasNext : function() : Boolean {
				return cur < x.length;
			}, next : function() : Xml {
				return x[cur++];
			}}
		}
		
		public function elements() : * {
			if(this._children == null) throw "bad nodetype";
			var cur : int = 0;
			var x : Array = this._children;
			return { hasNext : function() : Boolean {
				var k : int = cur;
				var l : int = x.length;
				while(k < l) {
					if(x[k].nodeType == Element) break;
					k += 1;
				}
				cur = k;
				return k < l;
			}, next : function() : Xml {
				var k : int = cur;
				var l : int = x.length;
				while(k < l) {
					var n : Xml = x[k];
					k += 1;
					if(n.nodeType == Element) {
						cur = k;
						return n;
					}
				}
				return null;
			}}
		}
		
		public function elementsNamed(name : String) : * {
			if(this._children == null) throw "bad nodetype";
			var cur : int = 0;
			var x : Array = this._children;
			return { hasNext : function() : Boolean {
				var k : int = cur;
				var l : int = x.length;
				while(k < l) {
					var n : Xml = x[k];
					if(n.nodeType == Element && n._nodeName == name) break;
					k++;
				}
				cur = k;
				return k < l;
			}, next : function() : Xml {
				var k : int = cur;
				var l : int = x.length;
				while(k < l) {
					var n : Xml = x[k];
					k++;
					if(n.nodeType == Element && n._nodeName == name) {
						cur = k;
						return n;
					}
				}
				return null;
			}}
		}
		
		public function firstChild() : Xml {
			if(this._children == null) throw "bad nodetype";
			return this._children[0];
		}
		
		public function firstElement() : Xml {
			if(this._children == null) throw "bad nodetype";
			var cur : int = 0;
			var l : int = this._children.length;
			while(cur < l) {
				var n : Xml = this._children[cur];
				if(n.nodeType == Element) return n;
				cur++;
			}
			return null;
		}
		
		public function addChild(x : Xml) : void {
			if(this._children == null) throw "bad nodetype";
			if(x._parent != null) x._parent._children.remove(x);
			x._parent = this;
			this._children.push(x);
		}
		
		public function removeChild(x : Xml) : Boolean {
			if(this._children == null) throw "bad nodetype";
			var b : Boolean = this._children.remove(x);
			if(b) x._parent = null;
			return b;
		}
		
		public function insertChild(x : Xml,pos : int) : void {
			if(this._children == null) throw "bad nodetype";
			if(x._parent != null) x._parent._children.remove(x);
			x._parent = this;
			this._children.insert(pos,x);
		}
		
		public function toString() : String {
			if(this.nodeType == PCData) return this._nodeValue;
			if(this.nodeType == CData) return "<![CDATA[" + this._nodeValue + "]]>";
			if(this.nodeType == Comment || this.nodeType == DocType || this.nodeType == Prolog) return this._nodeValue;
			var s : StringBuf = new StringBuf();
			if(this.nodeType == Element) {
				s.add("<");
				s.add(this._nodeName);
				{ var $it : * = this._attributes.keys();
				while( $it.hasNext() ) { var k : String = $it.next();
				{
					s.add(" ");
					s.add(k);
					s.add("=\"");
					s.add(this._attributes.get(k));
					s.add("\"");
				}
				}}
				if(this._children.length == 0) {
					s.add("/>");
					return s.toString();
				}
				s.add(">");
			}
			{ var $it2 : * = this.iterator();
			while( $it2.hasNext() ) { var x : Xml = $it2.next();
			s.add(x.toString());
			}}
			if(this.nodeType == Element) {
				s.add("</");
				s.add(this._nodeName);
				s.add(">");
			}
			return s.toString();
		}
		
		static protected var enode : EReg = new EReg("^<([a-zA-Z0-9:_-]+)","");
		static protected var ecdata : EReg = new EReg("^<!\\[CDATA\\[","i");
		static protected var edoctype : EReg = new EReg("^<!DOCTYPE","i");
		static protected var eend : EReg = new EReg("^</([a-zA-Z0-9:_-]+)>","");
		static protected var epcdata : EReg = new EReg("^[^<]+","");
		static protected var ecomment : EReg = new EReg("^<!--","");
		static protected var eprolog : EReg = new EReg("^<\\?[^\\?]+\\?>","");
		static protected var eattribute : EReg = new EReg("^\\s*([a-zA-Z0-9:_-]+)\\s*=\\s*(['\"])([^\\2]*?)\\2","");
		static protected var eclose : EReg = new EReg("^[ \\r\\n\\t]*(>|(/>))","");
		static protected var ecdata_end : EReg = new EReg("\\]\\]>","");
		static protected var edoctype_elt : EReg = new EReg("[\\[|\\]>]","");
		static protected var ecomment_end : EReg = new EReg("-->","");
		static public var Element : String;
		static public var PCData : String;
		static public var CData : String;
		static public var Comment : String;
		static public var DocType : String;
		static public var Prolog : String;
		static public var Document : String;
		static public function parse(str : String) : Xml {
			var rules : Array = [Xml.enode,Xml.epcdata,Xml.eend,Xml.ecdata,Xml.edoctype,Xml.ecomment,Xml.eprolog];
			var nrules : int = rules.length;
			var current : Xml = Xml.createDocument();
			var stack : List = new List();
			var line : int = 1;
			while(str.length > 0) {
				var i : int = 0;
				try {
					while(i < nrules) {
						var r : EReg = rules[i];
						if(r.match(str)) {
							switch(i) {
							case 0:{
								var x : Xml = Xml.createElement(r.matched(1));
								current.addChild(x);
								str = r.matchedRight();
								while(Xml.eattribute.match(str)) {
									x.set(Xml.eattribute.matched(1),Xml.eattribute.matched(3));
									str = Xml.eattribute.matchedRight();
								}
								if(!Xml.eclose.match(str)) {
									i = nrules;
									throw "__break__";
								}
								if(Xml.eclose.matched(1) == ">") {
									stack.push(current);
									current = x;
								}
								str = Xml.eclose.matchedRight();
							}break;
							case 1:{
								var text : String = r.matched(0);
								var p : int = 0;
								while(true) {
									p = text.indexOf("\n",p);
									if(p < 0) break;
									line++;
									p++;
								}
								var x2 : Xml = Xml.createPCData(text);
								current.addChild(x2);
								str = r.matchedRight();
							}break;
							case 2:{
								if(current._children != null && current._children.length == 0) {
									var e : Xml = Xml.createPCData("");
									current.addChild(e);
								}
								if(r.matched(1) != current._nodeName || stack.isEmpty()) {
									i = nrules;
									throw "__break__";
								}
								current = stack.pop();
								str = r.matchedRight();
							}break;
							case 3:{
								str = r.matchedRight();
								if(!Xml.ecdata_end.match(str)) throw "End of CDATA section not found";
								var x3 : Xml = Xml.createCData(Xml.ecdata_end.matchedLeft());
								current.addChild(x3);
								str = Xml.ecdata_end.matchedRight();
							}break;
							case 4:{
								var pos : int = 0;
								var count : int = 0;
								var old : String = str;
								try {
									while(true) {
										if(!Xml.edoctype_elt.match(str)) throw "End of DOCTYPE section not found";
										var p2 : * = Xml.edoctype_elt.matchedPos();
										pos += p2.pos + p2.len;
										str = Xml.edoctype_elt.matchedRight();
										switch(Xml.edoctype_elt.matched(0)) {
										case "[":{
											count++;
										}break;
										case "]":{
											count--;
											if(count < 0) throw "Invalid ] found in DOCTYPE declaration";
										}break;
										default:{
											if(count == 0) throw "__break__";
										}break;
										}
									}
								} catch( e : * ) { if( e != "__break__" ) throw e; }
								var x4 : Xml = Xml.createDocType(old.substr(0,pos));
								current.addChild(x4);
							}break;
							case 5:{
								if(!Xml.ecomment_end.match(str)) throw "Unclosed Comment";
								var p3 : * = Xml.ecomment_end.matchedPos();
								var x5 : Xml = Xml.createComment(str.substr(0,p3.pos + p3.len));
								current.addChild(x5);
								str = Xml.ecomment_end.matchedRight();
							}break;
							case 6:{
								var x6 : Xml = Xml.createProlog(r.matched(0));
								current.addChild(x6);
								str = r.matchedRight();
							}break;
							}
							throw "__break__";
						}
						i += 1;
					}
				} catch( e : * ) { if( e != "__break__" ) throw e; }
				if(i == nrules) {
					if(str.length > 10) throw ("Xml parse error : Unexpected " + str.substr(0,10) + "... line " + line);
					else throw ("Xml parse error : Unexpected " + str);
				}
			}
			if(!stack.isEmpty()) throw "Xml parse error : Unclosed " + stack.last().getNodeName();
			return current;
		}
		
		static public function createElement(name : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = Element;
			r._children = new Array();
			r._attributes = new Hash();
			r.setNodeName(name);
			return r;
		}
		
		static public function createPCData(data : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = PCData;
			r.setNodeValue(data);
			return r;
		}
		
		static public function createCData(data : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = CData;
			r.setNodeValue(data);
			return r;
		}
		
		static public function createComment(data : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = Comment;
			r.setNodeValue(data);
			return r;
		}
		
		static public function createDocType(data : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = DocType;
			r.setNodeValue(data);
			return r;
		}
		
		static public function createProlog(data : String) : Xml {
			var r : Xml = new Xml();
			r.nodeType = Prolog;
			r.setNodeValue(data);
			return r;
		}
		
		static public function createDocument() : Xml {
			var r : Xml = new Xml();
			r.nodeType = Document;
			r._children = new Array();
			return r;
		}
		
	}
}
