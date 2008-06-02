package org.goverla.events 
{
	
	import mx.collections.ArrayCollection;
	
	import org.goverla.utils.Objects;
	
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
			_listeners.addItem(listener);
		}
		
		public function addListenerIfHasNot(listener : Function) : void {
			if(!hasListener(listener)) {
				addListener(listener);
			}
		}
	
		public function removeListener(listener : Function) : void {
			if(!_listeners.contains(listener)) {
				throw new Error("List doesn't contain such listener");
			}
			_listeners.removeItemAt(_listeners.getItemIndex(listener));
		}
		
		public function removeListeners() : void {
			_listeners = new ArrayCollection();
		}

		public function setListener(listener : Function) : void {
			removeListeners();
			_listeners.addItem(listener);
		}
		
		public function sendEvent(eventObject : * = undefined) : void {
			if (_type == null || (_type != null && eventObject is _type)) {
				for(var index : int = 0; index < _listeners.length; index++) {
					var listener : Function = Objects.castToFunction(_listeners.getItemAt(index));
					if(eventObject == undefined)
					{
						listener();
					}
					else
					{
						listener(eventObject);
					}
				}
			} else {
				throw new TypeError("The eventObject has incorrect event type!");
			}
		}

		public function hasListeners() : Boolean {
			return _listeners.length > 0;
		}
		
		public function hasListener(func : Function) : Boolean {
			return _listeners.contains(func);
		}
	}
}