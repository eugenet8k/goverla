package org.goverla.utils {
	
	import flash.geom.Point;

	/**
	 * @author Maxym Hryniv
	 */
	public class Maths {
		
		public static function radiansToDegrees(value : Number) : Number {
			return value * 180 / Math.PI;
		}		

		public static function degreesToRadians(value : Number) : Number {
			return value * Math.PI / 180;
		}		

		public static function random(range : Number) : Number {
			return range > 0 ? Math.floor(Math.random()*range) : Math.ceil(Math.random()*range);
		}
		
		public static function getAxisAngle(startPoint : Point, endPoint : Point) : Number {
			var xDiff : Number = endPoint.x - startPoint.x;
			var yDiff : Number = endPoint.y - startPoint.y;
			var distance : Number = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
			var angle : Number = Math.acos(xDiff/distance)
			if(startPoint.y < endPoint.y) {
				angle = - angle;
			}
			return radiansToDegrees(angle);
		}
	}

}