package feffects.easing {
	import haxe.Public;
	public class Linear implements haxe.Public{
		static public function easeNone(t : Number,b : Number,c : Number,d : Number) : Number {
			return c * t / d + b;
		}
		
		static public function easeIn(t : Number,b : Number,c : Number,d : Number) : Number {
			return c * t / d + b;
		}
		
		static public function easeOut(t : Number,b : Number,c : Number,d : Number) : Number {
			return c * t / d + b;
		}
		
		static public function easeInOut(t : Number,b : Number,c : Number,d : Number) : Number {
			return c * t / d + b;
		}
		
	}
}
