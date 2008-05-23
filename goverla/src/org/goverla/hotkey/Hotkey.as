package org.goverla.hotkey {
	
	public class Hotkey {
		
		public function get key() : uint {
			return _key;
		}
		
		public function get isShiftPressed() : Boolean {
			return _isShiftPressed;
		}
		
		public function get isCtrlPressed() : Boolean {
			return _isCtrlPressed;
		}
		
		public function Hotkey(key : uint, isShiftPressed : Boolean = false, isCtrlPressed : Boolean = false) {
			_key = key;
			_isShiftPressed = isShiftPressed;
			_isCtrlPressed = isCtrlPressed;
		} 
		
		private var _key : uint;
		
		private var _isShiftPressed : Boolean;
		
		private var _isCtrlPressed : Boolean;

	}
	
}