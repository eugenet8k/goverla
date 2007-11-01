package org.goverla.core.collections.interfaces {

	public interface IMap {
		
		function addItem(key : Object, value : Object) : void;

		function removeItemAt(key : Object) : void;
		
		function getItem(key : Object) : Object;
		
		function clear() : void;
		
		function valueIterator() : IIterator;
		
		function keyIterator() : IIterator;
		
		function containsKey(key : Object) : Boolean;

		function get keys() : Array;

		function get values() : Array;
		
	}
	
}