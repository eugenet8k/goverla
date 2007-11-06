package org.goverla.utils.common {
	
	public class PairEntry {
		
        public static const empty : PairEntry = new PairEntry(null, null);

		private var _name : String;
		
		private var _value : Object;
		
		public function PairEntry(name : String, value : Object) {
			_name = name;
			_value = value;
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function set name(name : String) : void {
			_name = name;
		}
		
		public function get value() : Object {
			return _value;
		}
		
		public function set value(value : Object) : void {
			_value = value;
		}
		
	}
	
}