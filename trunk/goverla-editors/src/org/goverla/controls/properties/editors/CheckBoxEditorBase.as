package org.goverla.controls.properties.editors {

	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;

	public class CheckBoxEditorBase extends BaseEditor {
		
		public var checkBox : CheckBox;
		
		public function get itemLabel() : String {
			return _itemLabel;
		}
		
		public function set itemLabel(value : String) : void {
			 _itemLabel = value;
			 _itemLabelChanged = true;
			 invalidateProperties();
		}
		
		public function get itemField() : String {
			return _itemField;
		}
		
		public function set itemField(value : String) : void {
			 _itemField = value;
		}

		public override function get value() : Object {
			return _value;
		}
			
		public override function set value(value : Object) : void {
			_value = value;
			_valueChanged = true;
			invalidateProperties();
		}
		
		protected override function commitProperties() : void {
			super.commitProperties();
			
			if (_valueChanged) {
				_valueChanged = false;
				
				if (itemField == null) {
					checkBox.selected = Boolean(value);
				} else {
					checkBox.selected = (value != null) ? Boolean(value[itemField]) : false;
				}
			}
			
			if (_itemLabelChanged) {
				_itemLabelChanged = false;
				
				if (itemLabel != null || value != null) {
					BindingUtils.bindProperty(this, "label", value, itemLabel.split("."));
				}
			}
		}
		
		protected function onClick(event : Event) : void {
			changePropertyValue(itemField, checkBox.selected);
		}
		
		private var _value : Object;
		
		private var _valueChanged : Boolean;
		
		private var _itemLabel : String;
		
		private var _itemLabelChanged : Boolean;
		
		private var _itemField : String;
	
	}
	
}