package haxe {
	import feffects.Tween;
	import haxe.FastCell_feffects_Tween;
	public class FastList_feffects_Tween {
		public function FastList_feffects_Tween() : void {
			null;
		}
		
		public var head : haxe.FastCell_feffects_Tween;
		public function add(item : feffects.Tween) : void {
			this.head = new haxe.FastCell_feffects_Tween(item,this.head);
		}
		
		public function first() : feffects.Tween {
			return (this.head == null?null:this.head.elt);
		}
		
		public function pop() : feffects.Tween {
			var k : haxe.FastCell_feffects_Tween = this.head;
			if(k == null) return null;
			else {
				this.head = k.next;
				return k.elt;
			}
		}
		
		public function isEmpty() : Boolean {
			return (this.head == null);
		}
		
		public function remove(v : feffects.Tween) : Boolean {
			var prev : * = null;
			var l : haxe.FastCell_feffects_Tween = this.head;
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
			var l : haxe.FastCell_feffects_Tween = this.head;
			return { hasNext : function() : Boolean {
				return l != null;
			}, next : function() : feffects.Tween {
				var k : haxe.FastCell_feffects_Tween = l;
				l = k.next;
				return k.elt;
			}}
		}
		
		public function toString() : String {
			var a : Array = new Array();
			var l : haxe.FastCell_feffects_Tween = this.head;
			while(l != null) {
				a.push(l.elt);
				l = l.next;
			}
			return "{" + a.join(",") + "}";
		}
		
	}
}
