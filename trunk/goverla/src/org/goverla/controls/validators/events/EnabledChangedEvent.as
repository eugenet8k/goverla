package org.goverla.controls.validators.events {
	
	import org.goverla.controls.validators.interfaces.IValidator;
	
	import flash.events.Event;
	
	/**
	 * @author Tyutyunnyk Eugene
	 */
	public class EnabledChangedEvent extends Event {
		
		public const ENABLED_CHANGE : String = "enabledChanged";
		
		public function EnabledChangedEvent(target : IValidator) {
			super(ENABLED_CHANGE);
		}
	
	}
}