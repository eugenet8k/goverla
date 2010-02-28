package org.goverla.controls.properties.editors {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.TextInput;
	
	import org.goverla.controls.SizableTextArea;
	
	public class StringEditorBase extends BaseEditor {

		public var textInput : TextInput;
		
		public var sizeableTextArea : SizableTextArea;
		
		public function get itemField() : String {
			return _itemField;
		}
		
		public function set itemField(value : String) : void {
			 _itemField = value;
		}
		
		[Bindable]
		public function get multiline() : Boolean {
			return _multiline;
		}

		public function set multiline(value : Boolean) : void {
			_multiline = value;
		}
		
		public function get autoHeight() : Boolean {
			return _autoHeight;
		}

		public function set autoHeight(value : Boolean) : void {
			_autoHeight = value;
		}
		
		[Bindable]
		public override function get enabled() : Boolean {
			return _enabled;
		}
		
		public override function set enabled(value : Boolean) : void {
			_enabled = value;
		}
		
		public function get enabledField() : String {
			return _enabledField;
		}
		
		public function set enabledField(value : String) : void {
			 _enabledField = value;
			 _enabledFieldChanged = true;
			 invalidateProperties();
		}
		
		protected function get text() : String {
			return multiline ? sizeableTextArea.text : textInput.text;
		}

		protected function set text(value : String) : void {
			if (multiline) {
				sizeableTextArea.text = value;
			} else {
				textInput.text = value;
			}
		}
		
		[Bindable(event="change")]
		protected function get textValue() : String {
			if (itemField == null) {
				return value as String;
			} else {
				return (value != null) ? value[itemField] as String : null;
			}	
		}
		
		public override function setFocus() : void {
			if (multiline) {
				sizeableTextArea.setFocus();
			} else {
				textInput.setFocus();
			}
		}
		
		public override function parentChanged(p : DisplayObjectContainer) : void {
			super.parentChanged(p);
			
			if (p == null && _enabledChangeWatcher != null) {
				_enabledChangeWatcher.unwatch();
				_enabledChangeWatcher = null;
			}
		}
		
		protected override function commitProperties() : void {
			super.commitProperties();
			
			if (_enabledFieldChanged) {
				_enabledFieldChanged = false;
				
				if (enabledField != null)
				{
					_enabledChangeWatcher = 
						BindingUtils.bindProperty(this, "enabled", property.host, enabledField);
					enabled = Boolean(property.host[enabledField]);
				} else if (_enabledChangeWatcher != null) {
					_enabledChangeWatcher.unwatch();
					_enabledChangeWatcher = null;
				}
			}
		}
		
		protected function onTextInputChange() : void {
			changePropertyValue(itemField, text);
		}
		
		protected function onTextInputFocusIn() : void {
			_previousValue = text;			
		}
		
		protected function onTextInputFocusOut() : void {
			changePropertyValue(itemField, text);
		}
		
		protected function onKeyDown(event : KeyboardEvent) : void {
			if (event.ctrlKey) {
				if (event.keyCode != 0) {
					event.preventDefault();
				}
			} else if (event.keyCode == Keyboard.ESCAPE) {
				text = _previousValue;
				super.setFocus();
			} else if (multiline && event.keyCode == Keyboard.TAB && !event.shiftKey) {
				event.preventDefault();
				var caretIndex : int = sizeableTextArea.internalTextField.caretIndex;
				var currentText : String = sizeableTextArea.text;
				sizeableTextArea.text = currentText.slice(0, caretIndex) + String.fromCharCode(Keyboard.TAB) + 
					currentText.slice(caretIndex, currentText.length);
				sizeableTextArea.selectionBeginIndex = caretIndex + 1;
				sizeableTextArea.selectionEndIndex = caretIndex + 1;
				onTextInputChange();
			}
		}
		
		private var _itemField : String;
		
		private var _enabledField : String;
		
		private var _enabledFieldChanged : Boolean;
		
		private var _multiline : Boolean = false;
		
		private var _autoHeight : Boolean = false;
		
		private var _enabled : Boolean = true;
		
		private var _enabledChangeWatcher : ChangeWatcher;
		
		private var _previousValue : String;
	
	}
	
}