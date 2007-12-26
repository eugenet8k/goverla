package org.goverla.utils {

	import flash.geom.Point;
	
	import mx.core.Application;
	
	public class UIUtil {
		
		public static function getApplicationMousePosition() : Point {
			return new Point(Application.application.mouseX,
				Application.application.mouseY);
		}
		
		public static function getApplicationMouseShift(startPosition : Point) : Point {
			return new Point(Application.application.mouseX - startPosition.x,
					Application.application.mouseY - startPosition.y);
		}
		
		public static function sumPoint(point1 : Point, point2 : Point) : Point {
			return new Point(point1.x + point2.x, point1.y + point2.y);
		}
		
	}
	
}