package org.goverla.controls.properties.editors {
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.CheckBox;

	public class TwoCheckBoxesEditorBase extends BaseEditor {
		
		public var checkBox1 : CheckBox;
		
		public var checkBox2 : CheckBox;
		
		[Bindable]
		public function get label1() : String {
			return _label1;
		}
		
		public function set label1(value : String) : void {
			 _label1 = value;
		}
		
		[Bindable]
		public function get label2() : String {
			return _label2;
		}
		
		public function set label2(value : String) : void {
			 _label2 = value;
		}
		
		public function get itemLabel1() : String {
			return _itemLabel1;
		}
		
		public function set itemLabel1(value : String) : void {
			 _itemLabel1 = value;
			 _itemLabel1Changed = true;
			 invalidateProperties();
		}
		
		public function get itemField1() : String {
			return _itemField1;
		}
		
		public function set itemField1(value : String) : void {
			 _itemField1 = value;
		}
		
		public function get itemLabel2() : String {
			return _itemLabel2;
		}
		
		public function set itemLabel2(value : String) : void {
			 _itemLabel2 = value;
			 _itemLabel2Changed = true;
			 invalidateProperties();
		}
		
		public function get itemField2() : String {
			return _itemField2;
		}
		
		public function set itemField2(value : String) : void {
			 _itemField2 = value;
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
				
				if (value != null) {
					checkBox1.selected = (value != null) ? Boolean(value[itemField1]) : false;
					checkBox2.selected = (value != null) ? Boolean(value[itemField2]) : false;
				}
			}
			
			if (_itemLabel1Changed) {
				_itemLabel1Changed = false;
				
				if (value != null) {
					if (itemLabel1 != null) {
						BindingUtils.bindProperty(this, "label1", value, itemLabel1.split("."));
					}
				}
			}
			
			if (_itemLabel2Changed) {
				_itemLabel2Changed = false;
				
				if (value != null) {
					if (itemLabel1 != null) {
						BindingUtils.bindProperty(this, "label1", value, itemLabel1.split("."));
					}
				}
			}
		}
		
		protected function onClick1(event : Event) : void {
			changePropertyValue(itemField1, checkBox1.selected);
		}
		
		protected function onClick2(event : Event) : void {
			changePropertyValue(itemField2, checkBox2.selected);
		}
		
		private var _value : Object;
		
		private var _valueChanged : Boolean;
		
		private var _label1 : String;
		
		private var _label2 : String;		
		
		private var _itemLabel1 : String;
		
		private var _itemLabel1Changed : Boolean;
		
		private var _itemField1 : String;
		
		private var _itemLabel2 : String;
		
		private var _itemLabel2Changed : Boolean;
		
		private var _itemField2 : String
	
	}
	
}