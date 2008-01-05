package org.goverla.comparing
{
	import org.goverla.interfaces.IComparer;
	import org.goverla.utils.comparing.ComparingResult;

	public class PropertyComparer implements IComparer
	{
		private var _propertyName : String;
		
		public function PropertyComparer(propertyName : String) {
			_propertyName = propertyName;
		}
		
		public function compare(object1:Object, object2:Object):int
		{
			if(object1[_propertyName] > object2[_propertyName]) 
				return ComparingResult.GREATER;
			if(object1[_propertyName] < object2[_propertyName]) 
				return ComparingResult.SMALLER;
			
			return ComparingResult.EQUALS;
		}
		
	}
}