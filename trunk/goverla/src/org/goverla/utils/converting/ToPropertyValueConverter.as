package org.goverla.utils.converting {

	import org.goverla.interfaces.IConverter;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class ToPropertyValueConverter implements IConverter {
		
		private var _propertyName : String;
		
		public function ToPropertyValueConverter(propertyName : String) {
			_propertyName = propertyName;
		}
		
		public function convert(source : Object) : Object {
			return source[_propertyName];
		}
	
	}

}