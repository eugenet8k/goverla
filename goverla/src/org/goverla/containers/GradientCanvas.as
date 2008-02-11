package org.goverla.containers {

	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	import org.goverla.constants.StyleNames;
	import org.goverla.graphics.GraphicsUtil;
	import org.goverla.utils.Objects;

	[Style(name="fillColors",type="Array",format="Color",inherit="no")]
	
	[Style(name="fillAlphas",type="Array",format="Number",inherit="no")]
	
	[Style(name="fillAngle",type="Number",inherit="no")]
	
	public class GradientCanvas extends Canvas {
		
		private static const CLASS_NAME : String = "GradientCanvas";
		
        private static var classConstructed : Boolean = staticConstructor();        
		
		public function GradientCanvas() {
			super();
		}
    
        private static function staticConstructor() : Boolean {
            if (!StyleManager.getStyleDeclaration(CLASS_NAME)) {
                var newStyleDeclaration : CSSStyleDeclaration = new CSSStyleDeclaration();
                newStyleDeclaration.setStyle(StyleNames.FILL_COLORS, [0xFFFFFF, 0x000000]);
                newStyleDeclaration.setStyle(StyleNames.FILL_ALPHAS, [1, 1]);
                newStyleDeclaration.setStyle(StyleNames.FILL_ANGLE, 90);
                StyleManager.setStyleDeclaration(CLASS_NAME, newStyleDeclaration, true);
            }
            return true;
        }
        
        override public function styleChanged(styleProp : String) : void {
            super.styleChanged(styleProp);
			switch (styleProp) {
				case StyleNames.FILL_COLORS :
				case StyleNames.FILL_ALPHAS :
				case StyleNames.FILL_ANGLE :
	                invalidateDisplayList();
					break;
				default :
			}
        }
    
        override protected function updateDisplayList(unscaledWidth : Number, unscaledHeight : Number) : void {
        	var w : Number = unscaledWidth;
        	var h : Number = unscaledHeight;

            super.updateDisplayList(w, h);
            
        	graphics.clear();

            var fillColors : Array = Objects.castToArray(getStyle(StyleNames.FILL_COLORS));
            var fillAlphas : Array = Objects.castToArray(getStyle(StyleNames.FILL_ALPHAS));
            var fillAngle : Number = getStyle(StyleNames.FILL_ANGLE);
            var cornerRadius : Number = Objects.castToNumber(getStyle(StyleNames.CORNER_RADIUS));

            var fill : LinearGradient = new LinearGradient();
            fill.angle = fillAngle;
		    fill.entries = [new GradientEntry(fillColors[0], 0, fillAlphas[0]), new GradientEntry(fillColors[1], 1, fillAlphas[1])];

		    GraphicsUtil.fillRect(graphics, fill, new Rectangle(0, 0, w, h), cornerRadius);
        }

	}

}