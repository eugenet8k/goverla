package org.goverla.controls {
	
	import flash.events.Event;
	
	import mx.controls.TextArea;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;

	public class SizableTextArea extends TextArea {
		
		public override function set minHeight(value : Number) : void {
			super.minHeight = value;
			_minHeightChanged = true;
			invalidateProperties();
		}
		
		public override function set maxHeight(value : Number) : void {
			super.maxHeight = value;
			if (!isNaN(value) && value != 0) {
				verticalScrollPolicy = ScrollPolicy.AUTO;
			}
			_maxHeightChanged = true;
			invalidateProperties();
		}
		
		public override function set text(value : String) : void {
			_textChanged = true;
			if (!_creationComplete) {
				_text = value;
			} else {
				super.text = value;
				invalidateProperties();
			}
		}
		
		public function SizableTextArea() {
			super();
			addEventListener(Event.CHANGE, onChange);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			verticalScrollPolicy = ScrollPolicy.OFF;
		}
		
		protected override function commitProperties() : void
		{
			super.commitProperties();

			if (_minHeightChanged || _maxHeightChanged || _textChanged) {
				_minHeightChanged = false;
				_maxHeightChanged = false;
				_textChanged = false;
				refershHeight();
			}
		}
		
		private function onChange(event : Event) : void {
			refershHeight();
		}
		
		private function onCreationComplete(event : FlexEvent) : void {
			_creationComplete = true;
			if (_text != null) {
				text = _text;
			}
		}
		
		private function refershHeight() : void {
			var newHeight : Number = Math.max(textHeight + 10, minHeight);
			if (!isNaN(maxHeight) && maxHeight != 0) {
				height = Math.min(newHeight, maxHeight);
			}
			else
			{
				height = newHeight;
			}
		}
		
		private var _minHeightChanged : Boolean;
		
		private var _maxHeightChanged : Boolean;
		
		private var _textChanged : Boolean;
		
		private var _text : String;
		
		private var _creationComplete : Boolean;
		
	}
	
}