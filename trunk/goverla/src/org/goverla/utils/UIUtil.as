package org.goverla.utils {

	import flash.geom.Point;
	
	import mx.core.Application;
	
	public class UIUtil {
		
		public static function getApplicationMousePosition() : Point {
			return new Point(Application.application.mouseX,
				Application.application.mouseY);
		}
		
	}
	
}