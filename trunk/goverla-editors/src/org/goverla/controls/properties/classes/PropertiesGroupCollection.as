package org.goverla.controls.properties.classes {
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import org.goverla.model.GroupNameEntry;
	
	public class PropertiesGroupCollection extends ArrayCollection {
		
		public function PropertiesGroupCollection() {
			super();
			filterFunction = groupFilterFunction;
			refresh();
		}
		
		public function getGroup(name : String) : PropertiesGroup {
			filterFunction = null;
			refresh();
			
			var result : PropertiesGroup;
			for each (var group : PropertiesGroup in this) {
				if (group.name == name) {
					result = group;
					break;
				}
			}
			
			if (result == null) {
				result = new PropertiesGroup(new GroupNameEntry(name));
				addItem(result);
			}
			
			filterFunction = groupFilterFunction;
			refresh();
			
			return result;
		}
		
		public function addProperty(groupName : String, property : PropertyDefinition) : void {
			getGroup(groupName).properties.addItem(property);
			if (property.dependentGroupName != null) {
				property.addEventListener(Event.CHANGE, onPropertyWithDependentGroupChange, false, 0, true);
				setDependentGroupEnable(property);
			}
		}
		
		public function getProperty(groupName : String, propertyName : String) : PropertyDefinition {
			var result : PropertyDefinition;
			var properties : ArrayCollection = groupName == null ? properties : getGroup(groupName).properties;
			for each (var property : PropertyDefinition in properties) {
				if (property.name == propertyName) {
					result = property;
					break;
				}
			}
			
			return result;
		}

		public function deleteProperty(groupName : String, propertyName : String) : void {
			var group : PropertiesGroup = getGroup(groupName);
			for each (var property : PropertyDefinition in group.properties) {
				if (property.name == propertyName) {
					property.removeEventListener(Event.CHANGE, onPropertyWithDependentGroupChange);
					group.properties.removeItemAt(group.properties.getItemIndex(property));
					break;
				}
			}
		}
		
		private function onPropertyWithDependentGroupChange(event : Event) : void {
			setDependentGroupEnable(PropertyDefinition(event.target));
		}
		
		private function groupFilterFunction(item : Object) : Boolean {
			return PropertiesGroup(item).enabled;
		}
		
		private function setDependentGroupEnable(property : PropertyDefinition) : void {
			var dependentGroup : PropertiesGroup = getGroup(property.dependentGroupName);
			dependentGroup.enabled = property.value as Boolean;
			itemUpdated(dependentGroup);
		}

	}
	
}