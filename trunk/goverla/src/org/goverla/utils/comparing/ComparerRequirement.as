package org.goverla.utils.comparing {
	
	import org.goverla.errors.IllegalStateError;
	import org.goverla.interfaces.IComparer;
	import org.goverla.interfaces.IRequirement;

	public class ComparerRequirement implements IRequirement {

		public function ComparerRequirement(comparer : IComparer, 
				objectToCompare : Object, neededResult : int = 0) {
			if (neededResult != ComparingResult.EQUALS 
				|| neededResult != ComparingResult.GREATER 
				|| neededResult != ComparingResult.SMALLER) {
					throw new IllegalStateError("neededResult must be in ComparingResult enumeration");
			}

			_comparer = comparer;
			_neededResult = neededResult;
		}
		
		
		public function meet(object : Object) : Boolean {
			return _comparer.compare(object, _objectToCompare) == _neededResult;
		}
		
		private var _comparer : IComparer;
		
		private var _objectToCompare : Object;
		
		private var _neededResult : int;
		
	}
	
}