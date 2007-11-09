package org.goverla.controls {

	import mx.controls.LinkButton;
	
	import org.goverla.constants.StyleNames;
	import org.goverla.skins.ExtendedLinkButtonSkin;
	import org.goverla.utils.CSSUtils;
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
        		new PairEntry(StyleNames.UP_SKIN, ExtendedLinkButtonSkin),
	            new PairEntry(StyleNames.OVER_SKIN, ExtendedLinkButtonSkin),
	            new PairEntry(StyleNames.DOWN_SKIN, ExtendedLinkButtonSkin),
	            new PairEntry(StyleNames.DISABLED_SKIN, ExtendedLinkButtonSkin),
                new PairEntry(StyleNames.UP_BACKGROUND_COLOR, 0x000000),
                new PairEntry(StyleNames.UP_BACKGROUND_ALPHA, 0),
                new PairEntry(StyleNames.ROLL_OVER_ALPHA, 0),
                new PairEntry(StyleNames.SELECTION_ALPHA, 0),
                new PairEntry(StyleNames.DISABLED_BACKGROUND_COLOR, 0x000000),
                new PairEntry(StyleNames.DISABLED_BACKGROUND_ALPHA, 0));
        	
            return true;
        }

	}

}