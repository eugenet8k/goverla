package org.goverla.controls.properties.editors {
	
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	
	public class ComboBoxEditorBase extends BaseEditor {
		
		public var comboBox : ComboBox;
		
		[Bindable]
		public function get dataProvider() : Object {
			return _dataProvider;
		}		
		
		public function set dataProvider(value : Object) : void {
			if (value is ArrayCollection) {
				_dataProvider = ArrayCollection(value);
			}
			
			if (value is Array) {
				_dataProvider = new ArrayCollection(value as Array);
			}
			
			if (value is String) {
				_dataProvider = new ArrayCollection(String(value).split(","));
			}
		}
		
		public function get dataProviderField() : String {
			return _dataProviderField;
		}		
		
		public function set dataProviderField(value : String) : void {
			_dataProviderField = value;
			_dataProviderFieldChanged = true;
			invalidateProperties();
		}
		
		[Bindable]
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
			
			if (_dataProviderFieldChanged) {
				_dataProviderFieldChanged = false;
				
				dataProvider = property.getFieldValue(dataProviderField);
			}
			
			if (_valueChanged) {
				_valueChanged = false;
				
				comboBox.selectedItem = value;
			}
		}
		
		protected function onComboBoxChange() : void {
			changePropertyValue(null, comboBox.selectedItem);
		}
		
		private var _dataProvider : ArrayCollection;
		
		private var _value : Object;
		
		private var _valueChanged : Boolean;
		
		private var _dataProviderField : String;
		
		private var _dataProviderFieldChanged : Boolean;
		
		private var _itemField : String;
		
	}
	
}