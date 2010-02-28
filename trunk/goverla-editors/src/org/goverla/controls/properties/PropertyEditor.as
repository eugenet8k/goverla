package org.goverla.controls.properties {
	
	import mx.containers.Box;
	
	import org.goverla.controls.properties.classes.PropertyDefinition;
	import org.goverla.controls.properties.editors.BaseEditor;

	public class PropertyEditor extends Box {

		public function get property() : PropertyDefinition {
			return _property;
		}

		public function set property(value : PropertyDefinition) : void {
			_property = value;
			_propertyChanged = true;
			invalidateProperties();
		}
		
		public function get editor() : BaseEditor {
			return _editor;
		}
		
		protected override function commitProperties() : void {
			super.commitProperties();
			
			if (_propertyChanged) {
				_propertyChanged = false;
				
				if (_editor != null && _editor.property != property) {
					removeChild(_editor);
					_editor = null;
				}	
					
				if (_editor == null && property != null) {
					_editor = BaseEditor(new property.editorClass());
					_editor.property = property;			
					_editor.percentWidth = 100;
					addChild(_editor);
				}
			}
		}
		
		private var _property : PropertyDefinition;
		
		private var _propertyChanged : Boolean;
		
		private var _editor : BaseEditor;
		
	}
	
}