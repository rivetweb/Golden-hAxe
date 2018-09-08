package ;

import flash.MovieClip;

class DrawUtils {

	public static function dashTo(o:MovieClip,
			startx:Int, starty:Int, endx:Int, endy:Int, len:Int, gap:Int) {
		// startx, starty = beginning of dashed line
		// endx, endy = end of dashed line
		// len = length of dash
		// gap = length of gap between dashes

		// init vars
		var seglength, deltax, deltay, segs, cx, cy;
		// calculate the legnth of a segment
		seglength = len + gap;
		// calculate the length of the dashed line
		deltax = endx - startx;
		deltay = endy - starty;
		var delta = Math.sqrt((deltax * deltax) + (deltay * deltay));
		// calculate the number of segments needed
		segs = Math.floor(Math.abs(delta / seglength));
		// get the angle of the line in radians
		var radians = Math.atan2(deltay,deltax);
		// start the line here
		cx = startx;
		cy = starty;
		// add these to cx, cy to get next seg start
		deltax = Std.int(Math.cos(radians)*seglength);
		deltay = Std.int(Math.sin(radians)*seglength);
		// loop through each seg
		for (n in 0...segs) {
			o.moveTo(cx,cy);
			o.lineTo(cx+Math.cos(radians)*len,cy+Math.sin(radians)*len);
			cx += deltax;
			cy += deltay;
		}
		// handle last segment as it is likely to be partial
		o.moveTo(cx,cy);
		delta = Math.sqrt((endx-cx)*(endx-cx)+(endy-cy)*(endy-cy));
		if(delta>len){
		// segment ends in the gap, so draw a full dash
		o.lineTo(cx+Math.cos(radians)*len,cy+Math.sin(radians)*len);
		} else if(delta>0) {
		// segment is shorter than dash so only draw what is needed
		o.lineTo(cx+Math.cos(radians)*delta,cy+Math.sin(radians)*delta);
		}
		// move the pen to the end position
		o.moveTo(endx,endy);
	}	
}