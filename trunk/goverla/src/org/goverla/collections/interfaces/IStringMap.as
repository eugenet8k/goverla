package org.goverla.core.collections.interfaces {

	public interface IStringMap {
		
		function get length() : int;

		function put(key : String, value : Object) : void;

		function get(key : String) : Object;

		function valueIterator() : IIterator;
		
		function keyIterator() : IIterator;
		
		function clear() : void;

	}
}