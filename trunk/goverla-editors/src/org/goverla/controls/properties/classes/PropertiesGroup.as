package org.goverla.controls.properties.classes {

	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.goverla.constants.CustomMetadataKeyNames;
	import org.goverla.interfaces.INamedEntry;
	
	public class PropertiesGroup {
		
		[Bindable]
		public var nameEntry : INamedEntry;
		
		public var properties : ArrayCollection = new ArrayCollection();
		
		public var enabled : Boolean = true;
		
		public var collapsed : Boolean = true;
		
		public function get name() : String {
			return nameEntry.name;
		}
		
		public function PropertiesGroup(nameEntry : INamedEntry) {
			this.nameEntry = nameEntry;
			
			properties.sort = new Sort();
			properties.sort.fields = [new SortField(CustomMetadataKeyNames.INDEX, false, false, true)];
			properties.refresh();
		}

	}
	
}