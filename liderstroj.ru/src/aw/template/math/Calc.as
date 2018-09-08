/*
* @author Galaburda Oleg a_[w]
* http://actualwave.com/ 
*
*/

class aw.template.math.Calc {
	static public function toSquare(num:Number):Number{
		return Math.pow(num, 2);
	}
	static public function toCube(num:Number):Number{
		return Math.pow(num, 3);
	}
	static public function min():Number{
		if(!arguments.length) return null;
		var num:Number = Number(arguments.shift());
		var len:Number = arguments.length;
		for(var i:Number=0; i<len; i++){
			num = Math.min(num, arguments[i]);
		}
		return num;
	}
	static public function max():Number{
		if(!arguments.length) return null;
		var num:Number = Number(arguments.shift());
		var len:Number = arguments.length;
		for(var i:Number=0; i<len; i++){
			num = Math.max(num, arguments[i]);
		}
		return num;
	}
	static public function random(min:Number, max:Number):Number{
		if(!Calc.isNumber(min)) min = Number.MIN_VALUE;
		if(!Calc.isNumber(max)) max = Number.MAX_VALUE;
		return  Math.round(min+Math.random()*(max-min));
	}
	static public function randomArray(num:Number, min:Number, max:Number, noUnique:Boolean):Array{
		var arr:Array = new Array();
		if(Math.abs(max-min)<num) return Calc.valuesArray(min, max);
		for(var i:Number=0; i<num; i++){
			var value:Number = Calc.random(min, max);
			var dbl:Boolean = false;
			for(var j:Number=0; j<i && !noUnique; j++){
				if(arr[j]==value){
					dbl = true;
					break;
				}
			}
			if(dbl) i--;
			else arr.push(value);
		}
		return arr;
	}
	static public function randomValue(val1, val2, val3){
		return arguments[Math.floor(Math.random()*arguments.length)];
	}
	static public function valuesArray(min:Number, max:Number):Array{
		var arr:Array = new Array();
		if(max>min){
			for(var i:Number=min; i<=max; i++) arr.push(i);
		}else{
			for(var i:Number=max; i<=min; i++) arr.push(i);
		}
		
		return arr;
	}
	static public function isNumber(num):Boolean{
		if(typeof(num)=='number') return true;
		else return false;
	}
	static public function toNumber(obj):Number{
		var num:Number = Number(obj);
		if(isNaN(num)) return 0;
		else return num;
	}
	static public function toString(num:Number, len:Number):String{
		var str:String = num.toString();
		while(str.length<len) str = '0'+str;
		return str;
	}
	static public function perc(num:Number, max:Number):Number{
		return num/(max/100);
	}
	static public function numberByPerc(num:Number, perc:Number):Number{
		return (num/100)*perc;
	}
	static public function numberFromPerc(perc:Number, max:Number):Number{
		return perc*(max/100);
	}
	static public function maxByPerc(num:Number, perc:Number):Number{
		return 100*(num/perc);
	}
	static public function partByPerc(max1:Number, max2:Number, num2:Number):Number{
		return num2/max2*max1;
	}
}