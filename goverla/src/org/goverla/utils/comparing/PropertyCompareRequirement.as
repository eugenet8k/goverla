package org.goverla.utils.comparing {

	import org.goverla.utils.interfaces.IRequirement;
	
	/**
	 * @author Maxym Hryniv
	 */ 
	public class PropertyCompareRequirement implements IRequirement {
	
		private var _propertyName : String;
		
		private var _propertyValue : Object;
	
		public function PropertyCompareRequirement(properyName : String, propertyValue : Object) {
			_propertyName = properyName;
			_propertyValue = propertyValue;
		}
		
		public function meet(object : Object) : Boolean {
			return object[_propertyName] === _propertyValue;
		}
	
	}
}