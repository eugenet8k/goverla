package org.goverla.core.utils.interfaces {
	
	public interface IRequirement {
	
		/**
		 * @return true if object meets the requirement
		 */
		function meet(object : Object) : Boolean;
	
	}

}