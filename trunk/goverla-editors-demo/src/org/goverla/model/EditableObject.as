package org.goverla.model {
	
	import org.goverla.controls.properties.classes.PropertiesGroupCollection;
	import org.goverla.controls.properties.classes.PropertiesUtil;

	public class EditableObject {
	
		[Bindable]
		[Serializable]
		[Unique(defaultValue="macro")]
		[Editable(group="General", editor="StringEditor", label="name:",
			bindable="true", index="0")]
		public function get objectName() : String {
			return _objectName;
		}
		
		public function set objectName(value : String) : void {
			_objectName = value;
		}
		
		public function get propertiesGroups() : PropertiesGroupCollection {
			return _propertiesGroups;
		}
		
		public function EditableObject() {
			super();

			_propertiesGroups = PropertiesUtil.getPropertiesGroupsByMetadata(this);
		}

		private var _objectName : String;
		
		private var _propertiesGroups : PropertiesGroupCollection;
	}
	
}