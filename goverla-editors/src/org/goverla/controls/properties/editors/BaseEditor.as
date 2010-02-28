package org.goverla.controls.properties.editors {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.containers.Box;
	
	import org.goverla.controls.properties.classes.PropertyDefinition;
	import org.goverla.utils.Objects;

	public class BaseEditor extends Box	{

		public function get property() : PropertyDefinition {
			return _property;
		}
		
		public function set property(value : PropertyDefinition) : void {
			if (_property != null && _property.bindable) {
				_property.removeEventListener(Event.CHANGE, onPropertyChange);
			}
			
			_property = value;
			
			if (value != null) {
				if (value.bindable) {
					value.addEventListener(Event.CHANGE, onPropertyChange, false, 0, true);
				}
				
				label = value.label;
				initializeEditor(value.editorInitialization);
				updateValueByPropertyValue();
			}
		}

		[Bindable]
		public function get value() : Object {
			return _value;
		}

		public function set value(value : Object) : void {
			_value = value;
		}
		

		public function initializeEditor(initializationObject : Object) : void {
			for (var propertyName : String in initializationObject) {
				if (hasOwnProperty(propertyName) && !isBaseClassProperty(propertyName)) {
					this[propertyName] = Objects.parseToRightType(initializationObject[propertyName]);
				}
			}
		}
		
		public function updateValueByPropertyValue() : void {
			value = property.value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function updatePropertyValue() : void {
			property.value = value;
		}
		
		public override function parentChanged(p : DisplayObjectContainer) : void {
			super.parentChanged(p);
			
			if (p == null && property.bindableChangeWatcher != null) {
				property.bindableChangeWatcher.unwatch();
				property.bindableChangeWatcher = null;
				property = null;
			}
		}
		
		protected function changePropertyValue(itemField : String, value : Object) : void {
			if (itemField == null) {
				property.value = value;
			} else {
				if (property.value != null) {
					property.value[itemField] = value;
				}
			}
			updateValueByPropertyValue();			
		}
		
		private function onPropertyChange(event : Event) : void {
			updateValueByPropertyValue();
		}
		
		private function isBaseClassProperty(propertyName : String) : Boolean {
			return propertyName == "label";
		}
		
		private var _property : PropertyDefinition;

		private var _value : Object;
		
	}
	
}