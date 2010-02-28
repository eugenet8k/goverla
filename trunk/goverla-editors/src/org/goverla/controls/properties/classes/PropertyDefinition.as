package org.goverla.controls.properties.classes {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	[Event(name="change", type="flash.events.Event")]
	
	[Event(name="collectionChange", type="mx.events.CollectionEvent")]
	
	public class PropertyDefinition extends EventDispatcher {
		
		public var name : String;

		public var label : String;

		public var description : String;

		public var editorClass : Class;

		public var editorInitialization : Object;
		
		public var dependentGroupName : String;
		
		public var index : int;
		
		public var bindable : Boolean;
		
		public var host : Object;
		
		public var bindableChangeWatcher : ChangeWatcher;
		
		public function get value() : Object {
			return getFieldValue(name);
		}
		
		public function set value(value : Object) : void {
			setFieldValue(name, value);
			dispatchEvent(new Event(Event.CHANGE));
		}
				
		public function PropertyDefinition(name : String,
				host : Object,
				editorClass : Class, 
				editorInitialization : Object = null,
				dependentGroupName : String = null, 
				label : String = null, 
				description : String = null,
				index : int = 0,
				bindable : Boolean = false) {
			this.name = name;
			this.label = label;
			this.description = description;
			this.editorClass = editorClass;
			this.editorInitialization = editorInitialization;
			this.dependentGroupName = dependentGroupName;
			this.index = index;
			this.bindable = bindable;
			this.host = host;
			
			if (bindable) {
				if (host != null && ChangeWatcher.canWatch(host, name)) {
					// TODO: Check for memory leaks
					bindableChangeWatcher = ChangeWatcher.watch(host, name, onPropertyChange);
				}
				
				if (value is ArrayCollection) {
					ArrayCollection(value).addEventListener(CollectionEvent.COLLECTION_CHANGE, 
						onCollectionPropertyChange, false, 0, true);
				}
			}
		}
		
		public function getFieldValue(fieldName : String) : Object {
			return host[fieldName];
		}
		
		public function setFieldValue(fieldName : String, value : Object) : void {
			host[fieldName] = value;
		}
		
		private function onPropertyChange(event : Event) : void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onCollectionPropertyChange(event : Event) : void {
			dispatchEvent(event);
		}

	}

}