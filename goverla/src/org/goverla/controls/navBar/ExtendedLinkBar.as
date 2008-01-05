package org.goverla.controls.navBar {

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.containers.ViewStack;
	import mx.controls.Button;
	import mx.controls.LinkBar;
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	import mx.styles.ISimpleStyleClient;
	
	import org.goverla.controls.button.ExtendedLinkButton;
	import org.goverla.utils.Strings;

	[Style(name="upBackgroundColor", type="uint", format="Color", inherit="yes")]
	[Style(name="upBackgroundAlpha", type="Number", inherit="yes")]

	[Style(name="rollOverAlpha", type="Number", inherit="yes")]

	[Style(name="selectionAlpha", type="Number", inherit="yes")]

	[Style(name="disabledBackgroundColor", type="uint", format="Color", inherit="yes")]
	[Style(name="disabledBackgroundAlpha", type="Number", inherit="yes")]

	public class ExtendedLinkBar extends LinkBar {

		protected static const SEPARATOR_NAME : String = "_separator";

		public function ExtendedLinkBar() {
			super();
		}
		
		override public function get selectedIndex() : int {
			return super.selectedIndex;
		}
		
		override public function set selectedIndex(selectedIndex : int) : void {
			if (selectedIndex == -1) {
				if (super.selectedIndex != -1 && super.selectedIndex < numChildren) {
					var button : Button = Button(getChildAt(super.selectedIndex))
					button.enabled = true;
				}
				dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
			} else {
				super.selectedIndex = selectedIndex;
			}
		}
		
		public function get toggle() : Boolean {
			return _toggle;
		}
		
		public function set toggle(toggle : Boolean) : void {
			_toggle = toggle;
		}
		
		override protected function clickHandler(event : MouseEvent) : void {
			var index : int = getChildIndex(Button(event.currentTarget));
			if (!(dataProvider is ViewStack) && toggle) {
				hiliteSelectedNavItem(index);
			}
			super.clickHandler(event);
		}
		
		override protected function createNavItem(label : String, icon : Class = null) : IFlexDisplayObject {
			var pagerLinkButton : ExtendedLinkButton = new ExtendedLinkButton();
			pagerLinkButton.styleName = this;
			if (!Strings.isBlank(label)) {
				pagerLinkButton.label = label;
			} else {
				pagerLinkButton.label = " ";
			}
			if (icon) {
				pagerLinkButton.setStyle("icon", icon);
			}
			addChild(pagerLinkButton);
			pagerLinkButton.addEventListener(MouseEvent.CLICK, clickHandler);
			var separatorClass : Class = Class(getStyle("separatorSkin"));
			var separator : DisplayObject = DisplayObject(new separatorClass());
			separator.name = SEPARATOR_NAME + (numChildren - 1);
			if (separator is ISimpleStyleClient) {
				ISimpleStyleClient(separator).styleName = this;
			}
			rawChildren.addChild(separator);
			return pagerLinkButton;
		}
		
		private var _toggle : Boolean;
		
	}

}