package org.goverla.model {
	
	[Unique(properties="name")]
	public class FileExtensionEntry {

		[Bindable]
		[Serializable]
		[Unique(defaultValue="*.noname")]
		public function get name() : String {
			return _name;
		}

		public function set name(value : String) : void {
			_name = value;
		}
		
		private var _name : String;

	}
	
}