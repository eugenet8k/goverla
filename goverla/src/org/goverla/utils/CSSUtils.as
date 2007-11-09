package org.goverla.utils {

	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	import org.goverla.utils.common.PairEntry;

	public class CSSUtils {	
		
		public static function getStyleDeclaration(className : String) : CSSStyleDeclaration {
			var result : CSSStyleDeclaration = StyleManager.getStyleDeclaration(className);
        	return (result != null) ? result : new CSSStyleDeclaration();
		}
		
        public static function setDefaultStyles(className : String, ...defaultStyles) : void {
        	var defaultStyleDeclaration : CSSStyleDeclaration = getStyleDeclaration(className);
        				
        	for each (var defaultStyle : PairEntry in defaultStyles) {
        		if (defaultStyleDeclaration.getStyle(defaultStyle.name) == null) {
	        		defaultStyleDeclaration.setStyle(defaultStyle.name, defaultStyle.value);
        		}
        	}
        	
        	StyleManager.setStyleDeclaration(className, defaultStyleDeclaration, true);
        }

	}

}