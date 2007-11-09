package org.goverla.containers {

	import flash.geom.Rectangle;
	
	import mx.containers.Box;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	[Style(name="backgroundGradientColors",type="Array",format="Color",inherit="no")]
	
	[Style(name="backgroundGradientRatios",type="Array",format="Number",inherit="no")]
	
	[Style(name="backgroundGradientAlphas",type="Array",format="Number",inherit="no")]
	
	[Style(name="backgroundGradientAngle",type="Number",inherit="no")]

	public class GradientBox extends Box {

		protected static const CLASS_NAME : String = "GradientBox";

		protected static const BACKGROUND_GRADIENT_COLORS : String = "backgroundGradientColors";
		
		protected static const BACKGROUND_GRADIENT_RATIOS : String = "backgroundGradientRatios";
		
		protected static const BACKGROUND_GRADIENT_ALPHAS : String = "backgroundGradientAlphas";
		
		protected static const BACKGROUND_GRADIENT_ANGLE : String = "backgroundGradientAngle";
		
		protected static const CORNER_RADIUS : String = "cornerRadius";
		
        private static var classConstructed : Boolean = staticConstructor();

		public function GradientBox() {
			super();
		}
    
        private static function staticConstructor():Boolean {
            if (!StyleManager.getStyleDeclaration(CLASS_NAME)) {
                var newStyleDeclaration : CSSStyleDeclaration = new CSSStyleDeclaration();
                newStyleDeclaration.setStyle(BACKGROUND_GRADIENT_COLORS, [0xFFFFFF, 0x000000]);
                newStyleDeclaration.setStyle(BACKGROUND_GRADIENT_RATIOS, [0, 1]);
                newStyleDeclaration.setStyle(BACKGROUND_GRADIENT_ALPHAS, [1, 1]);
                newStyleDeclaration.setStyle(BACKGROUND_GRADIENT_ANGLE, 90);
                StyleManager.setStyleDeclaration(CLASS_NAME, newStyleDeclaration, true);
            }
            return true;
        }
    
        public override function styleChanged(styleProp : String) : void {
			switch(styleProp) {
				case BACKGROUND_GRADIENT_COLORS :
				case BACKGROUND_GRADIENT_RATIOS :
				case BACKGROUND_GRADIENT_ALPHAS :
				case BACKGROUND_GRADIENT_ANGLE :
		            super.styleChanged(styleProp);
	                invalidateDisplayList();
	                break;
				default :
            }
        }
    
        protected override function updateDisplayList(unscaledWidth : Number, unscaledHeight:Number):void {
        	var w : Number = unscaledWidth;
        	var h : Number = unscaledHeight;

            super.updateDisplayList(w, h);

        	graphics.clear();

		    var rectangle : Rectangle = new Rectangle(0, 0, w, h);

            var backgroundGradientColors : Array = (getStyle(BACKGROUND_GRADIENT_COLORS) as Array);
            var backgroundGradientRatios : Array = (getStyle(BACKGROUND_GRADIENT_RATIOS) as Array);
            var backgroundGradientAlphas : Array = (getStyle(BACKGROUND_GRADIENT_ALPHAS) as Array);
            var backgroundGradientAngle : Number = (getStyle(BACKGROUND_GRADIENT_ANGLE) as Number);
            var cornerRadius : Number = (getStyle(CORNER_RADIUS) as Number);

			var gradientEntries : Array = [];
            for (var i : int = 0; i < (backgroundGradientColors != null ? backgroundGradientColors.length : 0); i++) {
            	var gradientEntry : GradientEntry =
            		new GradientEntry(backgroundGradientColors[i],
            			backgroundGradientRatios[i],
            			backgroundGradientAlphas[i]);
            	gradientEntries.push(gradientEntry);
            }
            var linearGradient : LinearGradient = new LinearGradient();
            linearGradient.angle = backgroundGradientAngle;
		    linearGradient.entries = gradientEntries;
		    
			linearGradient.begin(graphics, rectangle);
			graphics.drawRoundRect(rectangle.left, rectangle.top, rectangle.width, rectangle.height, cornerRadius * 2);
			linearGradient.end(graphics);
        }
		
	}

}