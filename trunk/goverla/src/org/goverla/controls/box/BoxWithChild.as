package org.goverla.controls.box
{
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.containers.Box;
	import mx.core.UIComponent;
	
	import org.goverla.collections.ArrayList;

	public class BoxWithChild extends Box
	{
		public var widthByContent : Boolean = false;
		public var heightByContent : Boolean = false;
		
		
		private var _child : UIComponent;
		private var _watchers : ArrayList = new ArrayList();
		
		public function BoxWithChild()
		{
			super();
		}
		
		public function set child(value : UIComponent) : void {
			removeChildElement();
			if(value != null) {
				addChild(value);
				bindSize(heightByContent, value, "height");
				bindSize(widthByContent, value, "width");
				//value.percentHeight = 100;
				//value.percentWidth = 100;
			}
			_child = value;
		}
		
		public function get child() : UIComponent {
			return _child;
		}
		
		private function bindSize(bindDirection : Boolean, child : UIComponent, property : String) : void {
			var host : UIComponent = bindDirection ? child : this;
			var site : UIComponent = bindDirection ? this : child;
			_watchers.addItem(BindingUtils.bindProperty(site, property, host, property));
		}
		
		private function removeChildElement() : void {
			if(_child != null) {
				removeChild(_child);
				for each(var watcher : ChangeWatcher in _watchers) {
					watcher.unwatch();
				}
				_watchers.removeAll();
			}
		}
		
	}
}