package org.goverla.collections {

	import org.goverla.errors.CollectionError;
	import org.goverla.interfaces.IQueue;
	
	public class LinearQueue implements IQueue {

		private var _data : Array;
		
		public function LinearQueue(source : Array = null) {
			if(source != null) {
				_data = source;
			} else {
				_data = new Array();
			}
		}
		
		public function enqueue(item : Object) : void {
			_data.push(item);
		}
		
		public function dequeue() : Object {
			if(isEmpty()) {
				throw new CollectionError("Cannot dequeue from an empty queue");
			}
			return _data.shift();
		}
		
		public function isEmpty() : Boolean {
			return _data.length == 0;
		}
		
	}

}