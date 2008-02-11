package org.goverla.controls.editable.common {

	import mx.containers.Box;
	import mx.containers.BoxDirection;
	
	import org.goverla.constants.Icons;
	import org.goverla.events.SaveOrCancelBoxEvent;

	[Event(name="save", type="org.goverla.events.SaveOrCancelBoxEvent")]
	
	[Event(name="cancel", type="org.goverla.events.SaveOrCancelBoxEvent")]
	
	public class SaveOrCancelBoxBase extends Box {
		
		public static const BUTTON_STATE : String = "buttonState";
		
		public static const BUTTON_WITH_ICON_STATE : String = "buttonWithIconState";
		
		public static const LINK_BUTTON_STATE : String = "linkButtonState";
		
		public static const LINK_BUTTON_WITH_ICON_STATE : String = "linkButtonWithIconState";
		
		public static const ICON_STATE : String = "iconState";
		
		protected static const SAVE_ICON : Class = Icons.ICON_16X16_ACCEPT_UP;
		
		protected static const CANCEL_ICON : Class = Icons.ICON_16X16_DECLINE_UP;
		
		public function SaveOrCancelBoxBase() {
			super();
			
			currentState = BUTTON_STATE;
			direction = BoxDirection.HORIZONTAL;
		}
		
		protected function onSaveButtonClick() : void {
			dispatchEvent(new SaveOrCancelBoxEvent(SaveOrCancelBoxEvent.SAVE));
		}
		
		protected function onCancelButtonClick() : void {
			dispatchEvent(new SaveOrCancelBoxEvent(SaveOrCancelBoxEvent.CANCEL));
		}
		
	}

}