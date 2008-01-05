package org.goverla.hotkey
{
	import org.goverla.interfaces.IComparer;
	import org.goverla.utils.comparing.ComparingResult;

	public class HotkeyListenerComparer implements IComparer
	{
		
		private var _compareHandler : Boolean;
		
		public function HotkeyListenerComparer(compareHandler : Boolean = false) {
			_compareHandler = compareHandler;
		}
		
		public function compare(object1:Object, object2:Object):int
		{
			var result : int;
			var listener1 : HotkeyListener = HotkeyListener(object1);
			var listener2 : HotkeyListener = HotkeyListener(object2);
			result = new HotkeyComparer().compare(listener1.hotkey, listener2);
			if(_compareHandler && listener1.handler != listener2.handler) {
				result = ComparingResult.GREATER;
			}
			
			return result;
		}
		
	}
}