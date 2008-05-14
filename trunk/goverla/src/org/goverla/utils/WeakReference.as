package org.goverla.utils
{
	import flash.utils.Dictionary;
	
	import org.goverla.errors.IllegalStateError;
	
	public class WeakReference
	{
		private var _dictionary : Dictionary = new Dictionary(true);
		
		public function WeakReference(value : Object)
		{
			_dictionary[value] = true;
		}
		
		public function get value() : Object
		{
			var result : Object;
			for(var obj : Object in _dictionary)
			{
				if(result != null)
				{
					throw new IllegalStateError("More than one value in weakReference");
				}
				result = obj;
			}
			return result;
		}
		
		public function get alive() : Boolean
		{
			return value != null;
		}

	}
}