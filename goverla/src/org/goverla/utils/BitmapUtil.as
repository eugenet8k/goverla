package org.goverla.utils {
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	public class BitmapUtil {

		public static function capture(source : UIComponent,
			captureWidth : Number,
			captureHeight : Number,
			maintainAspectRatio : Boolean = true,
			colorTransform : ColorTransform = null,
			blendMode : String = null,
			clipRect : Rectangle = null,
			smoothing : Boolean = false) : BitmapData {
			
			if (maintainAspectRatio) {
				if (captureHeight / source.height > captureWidth / source.width) {
					captureHeight = source.height * (captureWidth / source.width);
				} else {
					captureWidth = source.width * (captureHeight / source.height);
				}
			}
			
			var result : BitmapData = new BitmapData(captureWidth, captureHeight);
			var matrix : Matrix = new Matrix();
			matrix.scale(captureWidth / source.width, captureHeight / source.height);
			result.draw(source, matrix, colorTransform, blendMode, clipRect, smoothing);
			
			return result;
		}		

	}
	
}