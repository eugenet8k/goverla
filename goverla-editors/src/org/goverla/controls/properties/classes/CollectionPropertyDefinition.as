package org.goverla.controls.properties.classes {

	public class CollectionPropertyDefinition extends PropertyDefinition {
		
		public override function get value() : Object {
			return _value;
		}
		
		public override function set value(value : Object) : void {}
		
		public function CollectionPropertyDefinition(name : String,
				value : Object,  
				editorClass : Class, 
				editorInitialization : Object = null, 
				label : String = null, 
				description : String = null,
				bindable : Boolean = false) {
			super(name, null, editorClass, editorInitialization, null, label, description, 0, bindable);
			_value = value;
		}
		
		private var _value : Object;
		
	}
	
}