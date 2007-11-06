package org.goverla.collections {
	
	import mx.collections.ArrayCollection;
	
	import org.goverla.errors.IllegalArgumentError;
	import org.goverla.interfaces.IIterator;
	import org.goverla.interfaces.IMap;
	
	public class HashMap implements IMap {
		
		public function HashMap(needSort : Boolean = false, sortOrder : * = null) {
			//setSort(needSort, sortOrder);
		}
		
		public function addItem(key : Object, value : Object) : void {
			if (_keys.contains(key)) {
				_values.setItemAt(value, _keys.getItemIndex(key))
			} else {
				_keys.addItem(key);
				_values.addItem(value);
				_notSorted = _needSort;
			}
		}
		
		public function removeItemAt(key : Object) : void {
			var index : int = _keys.getItemIndex(key);
			_keys.removeItemAt(index);
			_values.removeItemAt(index);
		}
		
		public function removeItem(value : Object) : void {
			var index : int = _values.getItemIndex(value);
			_keys.removeItemAt(index);
			_values.removeItemAt(index);
		}		
		
		public function getItem(key : Object) : Object {
			var index : int = _keys.getItemIndex(key);
			return (index > -1) ? _values.getItemAt(index) : null;	
		}

		public function valueIterator() : IIterator {
			return new ListCollectionViewIterator(_values);
		}

		public function keyIterator() : IIterator {
			return new ListCollectionViewIterator(_keys);
		}
		
		public function clear() : void {
			_keys.removeAll();
			_values.removeAll();
		}
		
		public function containsKey(key : Object) : Boolean {
			return _keys.contains(key);
		}
		
		public function containsItem(value : Object) : Boolean {
			return _values.contains(value);
		}
		
		public function get keys() : Array {
			if (_needSort && _notSorted ) {
				sort(false);
			}
			return _keys.toArray();
		}

		public function get values() : Array {
			//TODO: are we need sorted values?
			return _values.toArray();
		}
		
		public function toString() : String {
			return "HashMap sort=" + _needSort.toString();
		}

		public function setSort(enableSort : Boolean = false, sortOrder : * = null, sortImmediately : Boolean = false) : void {
			if (enableSort && (sortOrder != null)) {
				if ( sortOrder is String ) {
					_sortOrderTemplate = sortOrder.split(",");
				} else if (sortOrder is Array) {
					_sortOrderTemplate = sortOrder;
				} else {
					throw new IllegalArgumentError("sortOrder argument must be String or Array of String.");	
				}
			} else {
				_sortOrderTemplate = null;				
			}
			_notSorted = _needSort = enableSort;
			if (sortImmediately) {
				sort();
			}
		}
		
		public function sort(compulsory : Boolean = true) : void {
			if (_needSort && (_notSorted || compulsory)) {
				var newKeys : ArrayCollection = new ArrayCollection();
				var newValues : ArrayCollection = new ArrayCollection();
				var keysBuf : Array = _keys.toArray();;
				var index : int;
				var nextKey : String;
				for each(nextKey in _sortOrderTemplate) {
					index = keysBuf.indexOf(nextKey);
					if (index >=0) {
						newKeys.addItem(nextKey);
						newValues.addItem(_values.getItemAt(index));
						keysBuf[index] = null;
					}
				}
				keysBuf.sort();
				for each(nextKey in keysBuf) {
					if (nextKey != null) {
						index = _keys.getItemIndex(nextKey);
						newKeys.addItem(nextKey);
						newValues.addItem(_values.getItemAt(index));
					}
				}
				clear();
				_keys = newKeys;
				_values = newValues;
			}
			_notSorted = false;
		}

		private var _keys : ArrayCollection = new ArrayCollection();
		
		private var _values : ArrayCollection = new ArrayCollection();
		
		private var _needSort : Boolean;

		private var _notSorted : Boolean;

		private var _sortOrderTemplate : Array;

	}
}