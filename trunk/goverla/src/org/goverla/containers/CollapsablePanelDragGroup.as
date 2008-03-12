package org.goverla.containers {
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.IMXMLObject;
	import mx.core.UITextField;
	
	import org.goverla.events.CollapsablePanelEvent;
	import org.goverla.utils.UIUtil;

	public class CollapsablePanelDragGroup extends EventDispatcher implements IMXMLObject {
		
		protected var collapsablePanels : ArrayCollection = new ArrayCollection();
		
		public function CollapsablePanelDragGroup(target : IEventDispatcher = null) {
			super(target);
		}
		
		public function initialized(document : Object, id : String) : void {}
		
		public function addInstance(panel : CollapsablePanel) : void {
			if (!collapsablePanels.contains(panel)) {
				if (panel.dragable) {
					panel.addEventListener(MouseEvent.CLICK, onClick);
					panel.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					panel.addEventListener(CollapsablePanelEvent.STATE_CHANGE, onStateChange);
				}
				collapsablePanels.addItem(panel);
			}
		}
		
		public function removeInstance(panel : CollapsablePanel) : void {
			if (collapsablePanels.contains(panel)) {
				panel.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				panel.removeEventListener(CollapsablePanelEvent.STATE_CHANGE, onStateChange);
				collapsablePanels.removeItemAt(collapsablePanels.getItemIndex(panel));
			}
		}
		
		protected function onClick(event : MouseEvent) : void {
			var panel : CollapsablePanel = CollapsablePanel(event.currentTarget);
			if ((event.target is UITextField) && 
					(UITextField(event.target).parent == panel.titleComponent)) {
				if (panel.collapsed) {
					panel.restore();
				} else {
					panel.percentHeight = 100;
					panel.collapse();
				}
			}
		}
		
		protected function onMouseDown(event : MouseEvent) : void {
			_draggingPanel = CollapsablePanel(event.currentTarget);
			if (!_draggingPanel.collapsed && (event.target is UITextField) && 
					(UITextField(event.target).parent == _draggingPanel.titleComponent)) {
				_mousePosition = UIUtil.getApplicationMousePosition();
				
				Application.application.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				Application.application.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);				
			}
		}
		
		protected function onMouseUp(event : MouseEvent) : void {
			_mousePosition = null;
			_draggingPanel = null;
			
			Application.application.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Application.application.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function onMouseMove(event : MouseEvent) : void {
			if (_mousePosition != null) {
				var mouseCurrentPosition : Point = UIUtil.getApplicationMousePosition();
				var shift : Number = _mousePosition.y - mouseCurrentPosition.y;
				_mousePosition = mouseCurrentPosition;
				
				setHeight(_draggingPanel, shift);
			}
		}
		
		protected function onStateChange(event : CollapsablePanelEvent) : void {
			if (!CollapsablePanel(event.target).collapsed) {
				CollapsablePanel(event.target).percentHeight = 100;
			}
		}
		
		private function setHeight(panel : CollapsablePanel, shift : Number) : void {
			var limit : Boolean = true;
			for each (var otherPanel : CollapsablePanel in collapsablePanels) {
				if (panel != otherPanel && otherPanel.height > otherPanel.minHeight + shift) {
					limit = false;
				}
			}
			
			if (limit) {
				if (shift < 0) {
					panel.height += shift;
				}
			} else {
				if (shift > 0 || panel.height > panel.minHeight) {
					panel.height += shift;
				}
			}
		}
		
		private var _draggingPanel : CollapsablePanel;
				
		private var _mousePosition : Point;
		
	}
	
}