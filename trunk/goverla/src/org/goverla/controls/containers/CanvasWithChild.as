package org.goverla.controls.containers
{
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.containers.Canvas;
	import mx.core.UIComponent;

	public class CanvasWithChild extends Canvas
	{
		public var sizeByContent : Boolean = false;
		
		private var _child : UIComponent;
		private var _widthWatcher : ChangeWatcher;
		private var _heightWatcher : ChangeWatcher;
		
		public function CanvasWithChild()
		{
			super();
		}
		
		public function set child(value : UIComponent) : void {
			removeChildElement();
			if(value != null) {
				addChild(value);
				var host : UIComponent = sizeByContent ? value : this;
				var site : UIComponent = sizeByContent ? this : value;
				_widthWatcher = BindingUtils.bindProperty(site, "width", host, "width");
				_heightWatcher = BindingUtils.bindProperty(site, "height", host, "height");
			}
			_child = value;
		}
		
		public function get child() : UIComponent {
			return _child;
		}
		
		private function removeChildElement() : void {
			if(_child != null) {
				removeChild(_child);
				_widthWatcher.unwatch();
				_heightWatcher.unwatch();
			}
		}
	}
}