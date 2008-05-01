package org.goverla.controls {
	
	import flash.events.Event;
	
	import mx.controls.TextArea;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;

	public class SizableTextArea extends TextArea {
		
		public override function set minHeight(value : Number) : void {
			super.minHeight = value;
			refershHeight();
		}
		
		public function SizableTextArea() {
			super();
			addEventListener(Event.CHANGE, onChange);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			verticalScrollPolicy = ScrollPolicy.OFF;
		}
		
		private function onChange(event : Event) : void {
			refershHeight();
		}
		
		private function onCreationComplete(event : FlexEvent) : void {
			refershHeight();
		}
		
		private function refershHeight() : void {
			height = Math.max(textHeight + 10, minHeight);
		}
		
	}
	
}