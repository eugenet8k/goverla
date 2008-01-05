package org.goverla.controls.button.skins {

	import mx.skins.halo.LinkButtonSkin;

	public class ExtendedLinkButtonSkin extends LinkButtonSkin {
		
		public function ExtendedLinkButtonSkin() {
			super();
		}
		
		override protected function updateDisplayList(w : Number, h : Number) : void {
			super.updateDisplayList(w, h);
			
			var cornerRadius : Number = getStyle("cornerRadius");
			
			switch (name) {
				case "upSkin" :
					var backgroundColor : uint = getStyle("upBackgroundColor");
					var backgroundAlpha : Number = getStyle("upBackgroundAlpha");
					break;
				case "overSkin" :
					backgroundColor = getStyle("rollOverColor");
					backgroundAlpha = getStyle("rollOverAlpha");
					break;
				case "downSkin" :
					backgroundColor = getStyle("selectionColor");
					backgroundAlpha = getStyle("selectionAlpha");
					break;
				case "disabledSkin" :
					backgroundColor = getStyle("disabledBackgroundColor");
					backgroundAlpha = getStyle("disabledBackgroundAlpha");
					break;
				default :
			}
			
			graphics.clear();
			drawRoundRect(0, 0, w, h, cornerRadius, backgroundColor, backgroundAlpha);
		}

	}

}