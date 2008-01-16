package org.goverla.collections
{
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.goverla.comparing.ValueComparer;
	import org.goverla.interfaces.ICloneable;
	import org.goverla.interfaces.IComparer;
	import org.goverla.reflection.Overload;
	import org.goverla.serialization.interfaces.ISerializableBean;
	import org.goverla.sorting.QuickSorter;
	import org.goverla.utils.Arrays;

	[RemoteClass(alias="org.goverla.collections.ArrayList")]
	public class ArrayList extends ArrayCollection implements ICloneable, ISerializableBean
	{
		public function ArrayList(list : Object = null) {
			super();
			var overload : Overload = new Overload(this);
			overload.addHandler([Array], initializeByArray);
			overload.addHandler([ArrayCollection], initializeByArrayCollection);
			overload.forward([list]);
		}
		
		public function get ignoredProperties() : ArrayList {
			return new ArrayList(["ignoredProperties", "first", "last", "source"]);
		}

		protected function initializeByArray(source : Array) : void {
			this.source = source;
		} 

		protected function initializeByArrayCollection(source : ArrayCollection) : void {
			this.source = source.source;
		}
		
		public function get last() : Object {
			return getItemAt(length - 1);
		}
		
		public function get first() : Object {
			return getItemAt(0);
		}
		
		public function getItemIndices(item : Object) : ArrayList
		{
			var result : ArrayList = new ArrayList();
			for(var i : uint = 0; i < length; i++)
			{
				if(getItemAt(i) == item)
				{
					result.addItem(i);
				}
			}
			return result;
		}
		
		public function sortDefault() : void {
			sortBy(new ValueComparer());
		}

		public function sortBy(comparer : IComparer) : void {
			new QuickSorter().sort(this, comparer);
		}
		
		public function reverse() : void {
			source.reverse();
		}
		
		public function join(separator : String = "") : String {
			return source.join(separator);
		}
		
		public function clone() : Object {
			var result : ArrayList = new ArrayList();
			result.addItems(this);
			return result;
		}

		public function createIterator() : ListCollectionViewIterator {
			return new ListCollectionViewIterator(this);
		}
		
		public function addItems(source : ListCollectionView) : void {
			Arrays.insertAll(this, source);
		}
		
		public function addItemsAt(items : ListCollectionView, beginIndex : int) : void {
			Arrays.addItemsAt(this, items, beginIndex);
		}
		
		public function addFirst(item : Object) : void {
			addItemAt(item, 0);
		}
		
		public function addLast(item : Object) : void {
			addItem(item);
		}
		
		public function removeFirst() : Object {
			return removeItemAt(0);
		}

		public function removeLast() : Object {
			return removeItemAt(this.length - 1);
		}
		
		public function removeItems(items : ListCollectionView) : void {
			Arrays.removeAll(this, items); 
		}

		public function removeItem(item : Object) : void {
			removeItemAt(getItemIndex(item));
		}
		
		public function subList(beginIndex : int, count : int) : ArrayList {
			return new ArrayList(Arrays.subList(this, beginIndex, count));
		}
		
		public function retainItems(items : ListCollectionView) : void {
			var i : int = 0;
			while (i < length && length > 0) {
				if (items.contains(getItemAt(i))) {
					i++;
				}
				else{
					removeItemAt(i);
				}
			} 
		}
		
		public function replaceItem(item : Object, newItem : Object) : void {
			var index : uint = getItemIndex(item);
			setItemAt(newItem, index);
		}
		
		public function setItems(list : ListCollectionView, beginIndex : int) : void {
			if (beginIndex < 0 || list.length > (length - beginIndex)) {
				throw new RangeError("Argument 'beginIndex' [" + beginIndex + "] is out of range, this is less than 0 or the 'beginIndex' plus the length of the given 'list' [" + list.length + "] is greater than this ArrayList's length [" + length + "].");
			}
			
			var i : int = beginIndex;
			for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(list); iterator.hasNext();) {
				setItemAt(iterator.next(), i++);
			}
		}
		
		public function containsItems(items : ListCollectionView) : Boolean {
			var result : Boolean = true;
			
			for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(items); iterator.hasNext();) {
				if (!contains(iterator.next())) {
					result = false;
					break;
				}
			}
			
			return result;
		}
		
		public function toArrayCollection() : ArrayCollection {
			return new ArrayCollection(source);
		}
	}
}