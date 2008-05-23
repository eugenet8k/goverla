package org.goverla.hotkey {
	
	import flash.events.KeyboardEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.errors.IllegalArgumentError;
	import org.goverla.interfaces.IComparer;
	import org.goverla.interfaces.IRequirement;
	import org.goverla.utils.Arrays;
	import org.goverla.utils.comparing.ComparerRequirement;
	import org.goverla.utils.comparing.ComparingResult;

	internal class HotkeyManagerInstance {
		
		public function HotkeyManagerInstance() {
			Application(Application.application).addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
	
		public function addListener(hotkey : Hotkey, handler : Function) : void {
			_hotkeyListeners.addItem(new HotkeyListener(hotkey, handler));
		}
		
		public function removeListener(hotkey : Hotkey, handler : Function) : void {
			var comparer : IComparer = new HotkeyListenerComparer(true);
			var requirement : IRequirement 
				= new ComparerRequirement(comparer
					, new HotkeyListener(hotkey, handler)
					, [ComparingResult.EQUALS]);
			var listeners : ArrayCollection = Arrays.getByRequirement(_hotkeyListeners, requirement);
			if (listeners.length > 0) {
				_hotkeyListeners.removeItem(listeners.getItemAt(0));
			} else {
				throw new IllegalArgumentError("Cannot remove listener cause such listener doesn't exist");
			}
		}
		
		private function onKeyDown(event : KeyboardEvent) : void {
			var comparer : IComparer = new HotkeyListenerComparer(false);
			var hotkey : Hotkey = new Hotkey(event.keyCode, event.shiftKey, event.ctrlKey);
			var requirement : IRequirement 
				= new ComparerRequirement(comparer
					, new HotkeyListener(hotkey, null)
					, [ComparingResult.EQUALS]);
			var listeners : ArrayCollection = Arrays.getByRequirement(_hotkeyListeners, requirement);
			
			for each (var listener : HotkeyListener in listeners) {
				listener.handler(event);
			}
		}
		
		private var _hotkeyListeners : ArrayList = new ArrayList();
	
	}

}