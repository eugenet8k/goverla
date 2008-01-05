package org.goverla.controls.button {

	import mx.controls.LinkButton;
	
	import org.goverla.controls.button.skins.ExtendedLinkButtonSkin;
	import org.goverla.css.CSSUtils;
	import org.goverla.utils.common.PairEntry;

	[Style(name="upBackgroundColor", type="uint", format="Color", inherit="yes")]
	[Style(name="upBackgroundAlpha", type="Number", inherit="yes")]

	[Style(name="rollOverAlpha", type="Number", inherit="yes")]

	[Style(name="selectionAlpha", type="Number", inherit="yes")]

	[Style(name="disabledBackgroundColor", type="uint", format="Color", inherit="yes")]
	[Style(name="disabledBackgroundAlpha", type="Number", inherit="yes")]

	public class ExtendedLinkButton extends LinkButton {

		private static const CLASS_NAME : String = "ExtendedLinkButton";
		
		private static var classConstructed : Boolean = staticConstructor();

		public function ExtendedLinkButton() {
			super();
		}
		
        private static function staticConstructor() : Boolean {
        	CSSUtils.setDefaultStyles(CLASS_NAME,
        		new PairEntry("upSkin", ExtendedLinkButtonSkin),
	            new PairEntry("upSkin", ExtendedLinkButtonSkin),
	            new PairEntry("overSkin", ExtendedLinkButtonSkin),
	            new PairEntry("downSkin", ExtendedLinkButtonSkin),
	            new PairEntry("disabledSkin", ExtendedLinkButtonSkin),
                new PairEntry("upBackgroundColor", 0x000000),
                new PairEntry("upBackgroundAlpha", 0),
                new PairEntry("rollOverAlpha", 0),
                new PairEntry("selectionAlpha", 0),
                new PairEntry("disabledBackgroundColor", 0x000000),
                new PairEntry("disabledBackgroundAlpha", 0));
        	
            return true;
        }
        
        override protected function measure() : void {
        	super.measure();
        	
        	measuredWidth -= 5;
        	measuredMinWidth -= 5;
        	measuredHeight -= 4;
        	measuredMinHeight -= 4;
        }

	}

}