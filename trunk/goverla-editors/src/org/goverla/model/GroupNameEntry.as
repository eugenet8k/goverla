package org.goverla.model {
	
	import org.goverla.interfaces.INamedEntry;
	
	[Unique(properties="name")]
	public class GroupNameEntry implements INamedEntry	{
		
		[Bindable]
		[Unique(defaultValue="groupName")]
		public function get name() : String {
			return _name;
		}

		public function set name(value : String) : void {
			_name = value;
		}
		
		public function GroupNameEntry(name : String = null) {
			_name = name;
		}
		
		private var _name : String;

	}
	
}