package org.goverla.model {
	
	import org.goverla.interfaces.INamedEntry;
	
	[Unique(properties="name")]
	public class MemberEntry implements INamedEntry {
		
		[Bindable]
		[Unique(defaultValue="member")]
		public function get name() : String {
			return _name;
		}

		public function set name(value : String) : void {
			_name = value;
		}
		
		[Bindable]
		public function get enabled() : Boolean {
			return _enabled;
		}

		public function set enabled(value : Boolean) : void {
			_enabled = value;
		}
		
		public function MemberEntry(name : String = null) {
			_name = name;
		}
		
		private var _name : String;
		
		private var _enabled : Boolean = true;

	}
	
}