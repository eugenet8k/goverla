package org.goverla.remoting
{
	public class RemoteCall
	{
		private var _managerId : String;
		private var _methodName : String;
		private var _args : Array;
		
		public function RemoteCall(managerId : String, methodName : String, args : Array) {
			_managerId = managerId;
			_methodName = methodName;
			_args = args;
		}
		
		public function get managerId() : String {
			return _managerId;
		}

		public function set managerId(value : String) : void {
			_managerId = value;
		}

		public function get methodName() : String {
			return _methodName;
		}
		
		public function set methodName(value : String) : void {
			_methodName = value;
		}
		
		public function get args() : Array {
			return _args;
		}
		
		public function set args(value : Array) : void {
			_args = value;
		}
		
	}
}