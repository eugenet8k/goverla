package org.goverla.geom
{
	[RemoteClass(alias="org.goverla.geom.Size")]
	public class Size
	{
		private var _width : Number;
		private var _height : Number;
		
		public function Size(width : Number = 0, height : Number = 0) {
			_width = width;
			_height = height;
		}
		
		[Bindable]
		public function get width() : Number {
			return _width;
		}
		
		public function set width(value : Number) : void {
			_width = value;
		}
		
		[Bindable]
		public function get height() : Number {
			return _height;
		}
		
		public function set height(value : Number) : void {
			_height = value;
		}
	}
}