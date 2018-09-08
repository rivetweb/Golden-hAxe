/*
* @author Galaburda Oleg a_[w]
* http://actualwave.com/ 
*
*/

import aw.template.math.Calc;
import flash.geom.Point;
class aw.template.geom.Geometry{
	static function toDegree(val:Number):Number{
		return val*180/Math.PI;
	}
	static function toRadian(val:Number):Number{
		return val*Math.PI/180;
	}
	//------------- All methods use(in/out) angle in radians
	//========= Distance And Points
	static public function getDistanceByPoints(x1:Number, y1:Number, x2:Number, y2:Number):Number{
		return Math.sqrt(Calc.toSquare(x2-x1)+Calc.toSquare(y2-y1));
	}
	static public function getPointsByDistance(x:Number, y:Number, len:Number, angle:Number):Point{
		return new Point(x+len*Math.cos(angle), y+len*Math.sin(angle));
	}
	//========= Angle
	static public function getAngleByPoints(x1:Number, y1:Number, x2:Number, y2:Number):Number{
		return Math.atan2(y2-y1, x2-x1);
	}
	static public function getFullAngleByPoints(x1:Number, y1:Number, x2:Number, y2:Number):Number{
		var angle:Number = getAngleByPoints(x1, y1, x2, y2);
		angle += PI_2;
		/*
		if(y2<y1 && x2>=x1) angle += 0;
		else if(y2>=y1 && x2>x1) angle += 1.5707963267949;
		else if(y2>y1 && x2<=x1) angle += 3.14159265358979;
		else if(y2<=y1 && x2<x1) angle += 4.71238898038469;
		*/
		return angle;
	}
	//========= Rotation
	// {minx, miny, maxx, maxy};
	static public function getRectPointsByAngle(mc:MovieClip, angle:Number, noBackRotation:Boolean):Object{
		var rotation:Number = mc._rotation;
		mc._rotation = 0;
		var points:Object = null;
		var p:Object = {};
		var tr = getDistanceByPoints(mc._x, mc._y, mc._x+mc._width, mc._y);
		var bl = getDistanceByPoints(mc._x, mc._y, mc._x, mc._y+mc._height);
		var br = getDistanceByPoints(mc._x, mc._y, mc._x+mc._width, mc._y+mc._height);
		var bla = getAngleByPoints(mc._x, mc._y, mc._x, mc._y+mc._height);
		var bra = getAngleByPoints(mc._x, mc._y, mc._x+mc._width, mc._y+mc._height);
		points = getPointsByDistance(mc._x, mc._y, tr, angle);
		p.x1 = points.x;
		p.y1 = points.y;
		points = getPointsByDistance(mc._x, mc._y, bl, bla+angle);
		p.x2 = points.x;
		p.y2 = points.y;
		points = getPointsByDistance(mc._x, mc._y, br, bra+angle);
		p.x3 = points.x;
		p.y3 = points.y;
		if(!noBackRotation) mc._rotation = rotation;
		return {minx: Calc.min(mc._x, p.x1, p.x2, p.x3), miny: Calc.min(mc._y, p.y1, p.y2, p.y3),
				maxx: Calc.max(mc._x, p.x1, p.x2, p.x3), maxy: Calc.max(mc._y, p.y1, p.y2, p.y3), rotation:rotation};
	}
	static public function get PI_2():Number{
		return 1.5707963267949;
	}
}