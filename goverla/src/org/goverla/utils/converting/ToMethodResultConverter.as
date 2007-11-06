package org.goverla.utils.converting {
	
	import org.goverla.interfaces.IConverter;

	public class ToMethodResultConverter implements IConverter {
		
		private var _methodName : String;
	
		private var _arguments : Array;
		
		public function ToMethodResultConverter(methodName : String, args : Array = null) {
			_methodName = methodName;
			_arguments = args;
		}
		
		public function convert(source : Object) : Object {
			var method : Function = source[_methodName] as Function;
			return method.apply(source, _arguments);
		}
	
	}
}