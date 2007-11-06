package org.goverla.utils.comparing {
	
	import mx.collections.ArrayCollection;
	
	import org.goverla.interfaces.IRequirement;

	public class UniqueFieldRequirement implements IRequirement	{
		
		private var _fieldName : String;
		
		private var _fieldValues : ArrayCollection = new ArrayCollection();
		
		public function UniqueFieldRequirement(fieldName : String) {
			_fieldName = fieldName;
		}
		
		public function meet(object:Object):Boolean	{
			var result : Boolean = !_fieldValues.contains(object[_fieldName]);
			if (result) {
				_fieldValues.addItem(object[_fieldName]);
			}
			
			return result;
		}
		
	}
	
}