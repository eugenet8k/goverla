package org.goverla.controls.properties {
	
	import mx.containers.Panel;
	
	import org.goverla.controls.properties.classes.PropertiesGroupCollection;

	public class PropertiesEditorBase extends Panel {
		
		[Bindable]
		public function get propertiesGroups() : PropertiesGroupCollection {
			return _propertiesGroups;
		}
		
		public function set propertiesGroups(value : PropertiesGroupCollection) : void {
			_propertiesGroups = value;
		}

		private var _propertiesGroups : PropertiesGroupCollection;
		
	}
	
}