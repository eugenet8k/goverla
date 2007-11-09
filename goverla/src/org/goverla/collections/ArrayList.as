package org.goverla.collections {
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.goverla.utils.Arrays;

	public class ArrayList extends ArrayCollection {
		
		public function ArrayList(list : ArrayCollection = null) {
			super();
			if (list != null) {
				initializeByArrayCollection(list)
			}
		}

		protected function initializeByArray(source : Array) : void {
			this.source = source;
		} 

		protected function initializeByArrayCollection(source : ArrayCollection) : void {
			this.source = source.source;
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
			this.addItemAt(item, 0);
		}
		
		public function addLast(item : Object) : void {
			this.addItem(item);
		}
		
		public function removeFirst() : Object {
			return this.removeItemAt(0);
		}

		public function removeLast() : Object {
			return this.removeItemAt(this.length - 1);
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
		
	}
	
}