package org.goverla.controls.text
{
	import org.goverla.utils.Strings;
	
	import flash.events.Event;
	import flash.text.TextLineMetrics;
	
	import mx.controls.TextArea;
	import mx.events.FlexEvent;

	public class SizableTextArea extends TextArea
	{
		private static const OFF : String = "off";
		public function SizableTextArea() {
			addEventListener(Event.CHANGE, onChange);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			verticalScrollPolicy = OFF;
		}
		
		override public function set minHeight(value:Number):void {
			super.minHeight = value;
			refershHeight();
		}
		
		override public function set htmlText(value:String):void {
			super.htmlText = value;
		}
		
		override public function set text(value:String):void {
			if(Strings.isBlank(value)) {
				trace("`");
			}
			super.text = value;
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