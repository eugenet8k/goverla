package org.goverla.core.reflect.overload {
	
	import mx.collections.ArrayCollection;
	
	import org.goverla.core.reflect.overload.common.OverloadHandler;
	import org.goverla.core.reflect.overload.errors.OverloadError;
	
	public class Overload
	{
		private var _handlers : ArrayCollection = new ArrayCollection();
		
		private var _thisObject : Object;
		
		public function Overload(thisObject : Object) : void {
			_thisObject = thisObject;
		}
		
		public function addHandler(types : Array, handler : Function) : void {
			_handlers.addItem(new OverloadHandler(types, handler));
		}

		public function forward(arguments : Array) : Object {
			var overloadHandler : OverloadHandler = null;
			for (var i : int = 0; i < _handlers.length; i++) {
				var currentHandler : OverloadHandler = OverloadHandler(_handlers.getItemAt(i));
				if (currentHandler.match(arguments)) {
					overloadHandler = currentHandler;
					break;
				}
			}

			if (overloadHandler == null) {
				throw new OverloadError("There is no appropriate handler");
			}
			
			return overloadHandler.handler.apply(_thisObject, arguments);
		}
		
	}
}