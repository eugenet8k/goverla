package org.goverla.utils {
	
	import org.goverla.constants.StyleConstants;
	
	[RemoteClass(alias="org.goverla.utils.FontDescription")]
	
	public class FontDescription {
		
		public function FontDescription(name : String = "Arial", size : uint = 12) {
			_name = name;
			_size = size;
		}
		
		public function get name() : String {
			return _name;
		}

		public function set name(value : String) : void {
			_name = value;
		}
		
		public function get isBold() : Boolean {
			return _isBold;
		}

		public function set isBold(value : Boolean) : void {
			_isBold = value;
		}
		
		public function get isItalic() : Boolean {
			return _isItalic;
		}

		public function set isItalic(value : Boolean) : void {
			_isItalic = value;
		}
		
		public function get isUnderline() : Boolean {
			return _isUnderline;
		}

		public function set isUnderline(value : Boolean) : void {
			_isUnderline = value;
		}
		
		public function get size() : uint {
			return _size;
		}

		public function set size(value : uint) : void {
			_size = value;
		}
		
		public function get color() : uint {
			return _color;
		}

		public function set color(value : uint) : void {
			_color = value;
		}

		public function get align() : String {
			return _align;
		}

		public function set align(value : String) : void {
			_align = value;
		}
		
		private var _name : String;
		
		private var _isBold : Boolean;
		
		private var _isItalic : Boolean;
		
		private var _isUnderline : Boolean;
		
		private var _size : uint;
		
		private var _color : uint;
		
		private var _align : String = StyleConstants.ALIGN_LEFT;

	}
	
}