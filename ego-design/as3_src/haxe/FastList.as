package haxe {
	import haxe.FastCell;
	public class FastList {
		public function FastList() : void {
			null;
		}
		
		public var head : haxe.FastCell;
		public function add(item : *) : void {
			this.head = new haxe.FastCell(item,this.head);
		}
		
		public function first() : * {
			return (this.head == null?null:this.head.elt);
		}
		
		public function pop() : * {
			var k : haxe.FastCell = this.head;
			if(k == null) return null;
			else {
				this.head = k.next;
				return k.elt;
			}
		}
		
		public function isEmpty() : Boolean {
			return (this.head == null);
		}
		
		public function remove(v : *) : Boolean {
			var prev : * = null;
			var l : haxe.FastCell = this.head;
			while(l != null) {
				if(l.elt == v) {
					if(prev == null) this.head = l.next;
					else prev.next = l.next;
					break;
				}
				prev = l;
				l = l.next;
			}
			return (l != null);
		}
		
		public function iterator() : * {
			var l : haxe.FastCell = this.head;
			return { hasNext : function() : Boolean {
				return l != null;
			}, next : function() : * {
				var k : haxe.FastCell = l;
				l = k.next;
				return k.elt;
			}}
		}
		
		public function toString() : String {
			var a : Array = new Array();
			var l : haxe.FastCell = this.head;
			while(l != null) {
				a.push(l.elt);
				l = l.next;
			}
			return "{" + a.join(",") + "}";
		}
		
	}
}
