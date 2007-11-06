package org.goverla.events {
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class EventSender {

		private var _listeners : ArrayCollection = new ArrayCollection();
		
		private var _type : Class;
		
		public function EventSender(type : Class = null) {
			_type = type;
		}
		
		public function addListener(listener : Function) : void {
			if(hasListener(listener)) {
				throw new Error("Allready have this listener");
			} else {
				_listeners.addItem(listener);	
			}
		}

		public function addListenerIfHasNot(listener : Function) : void {
			if(!hasListener(listener)) {
				_listeners.addItem(listener);
			}
		}
	
		public function removeListener(listener : Function) : void {
			if(!_listeners.contains(listener)) {
				throw new Error("List doesn't contain such listener");
			}
			_listeners.removeItemAt(_listeners.getItemIndex(listener));
		}

		public function sendEvent(eventObject : Event) : void {
			if (_type == null || (_type != null && eventObject is _type)) {
				for(var index : int = 0; index < _listeners.length; index++) {
					var listener : Function = _listeners.getItemAt(index) as Function;
					listener(eventObject);
				}
			} else {
				throw new TypeError("The eventObject has incorrect event type!");
			}
		}

		public function hasListener(func : Function) : Boolean {
			return _listeners.contains(func);
		}
	}
}