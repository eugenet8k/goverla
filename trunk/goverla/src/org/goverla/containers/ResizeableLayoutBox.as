package org.goverla.containers {
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.goverla.events.ResizeableLayoutEvent;
	import org.goverla.interfaces.IResizableLayoutChild;
	import org.goverla.utils.UIUtil;

	public class ResizeableLayoutBox extends Box {
		
		public function ResizeableLayoutBox() {
			super();
			
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		protected function onCreationComplete(event : FlexEvent) : void {
			for (var i : int = 1; i < numChildren; i++) {
				var child : UIComponent = UIComponent(getChildAt(i));
				child.addEventListener(ResizeableLayoutEvent.START_RESIZE, onChildStartResize);
			}
		}
		
		protected function onChildStartResize(event : ResizeableLayoutEvent) : void {
			_resizingChildIndex = getChildIndex(UIComponent(event.target));
			_previousChildIndex = getPreviousChildIndex();
			
			if (_previousChildIndex >= 0) {
				for (var i : uint = 0; i < numChildren; i++) {
					if (i < _previousChildIndex || i > _resizingChildIndex) {
						if (direction == BoxDirection.VERTICAL) {
							getChildAt(i).height = getChildAt(i).height;
						} else {
							getChildAt(i).width = getChildAt(i).width;
						}
					}
					
					if (i == _previousChildIndex) {
						if (direction == BoxDirection.VERTICAL) {
							UIComponent(getChildAt(i)).percentHeight = 100;
						} else {
							UIComponent(getChildAt(i)).percentWidth = 100;
						}
					}
				}
				
				if (direction == BoxDirection.VERTICAL) {
					_startSize = getChildAt(_previousChildIndex).height + getChildAt(_resizingChildIndex).height;
				} else {
					_startSize = getChildAt(_previousChildIndex).width + getChildAt(_resizingChildIndex).width;
				}
	
				_currentMousePosition = UIUtil.getApplicationMousePosition();
	
				Application.application.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				Application.application.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		protected function onMouseUp(event : MouseEvent) : void {
			_resizingChildIndex = -1;
			_previousChildIndex = -1;
			_startSize = NaN;
			_currentMousePosition = null;
			
			Application.application.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Application.application.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function onMouseMove(event : MouseEvent) : void {
			if (_resizingChildIndex != -1) {
				var shift : Point = UIUtil.getApplicationMouseShift(_currentMousePosition);
				_currentMousePosition = UIUtil.getApplicationMousePosition();
				
				setChildHeight(shift);
			}
		}
		
		private function setChildHeight(shift : Point) : void {
			var previousChild : UIComponent = UIComponent(getChildAt(_previousChildIndex));
			var child : UIComponent = UIComponent(getChildAt(_resizingChildIndex));
						
			if (direction == BoxDirection.VERTICAL) {
				if (shift.y < 0) {
					if (_startSize - (child.height - shift.y) > previousChild.minHeight) {
						child.height -= shift.y;
					}
				} else {
					if (child.height - shift.y > child.minHeight) {
						child.height -= shift.y;
					}					
				}
			} else {
				if (shift.x < 0) {
					if (_startSize - (child.width - shift.x) > previousChild.minWidth) {
						child.width -= shift.x;shift.y;
					}
				} else {
					if (child.width - shift.x > child.minWidth) {
						child.width -= shift.x;
					}					
				}
			}
		}
		
		private function getPreviousChildIndex() : int {
			for (var i : int = _resizingChildIndex - 1; i >= 0; i--) {
				if (IResizableLayoutChild(getChildAt(i)).resizeable) {
					return i;
				}
			}
			return -1;
		}
		
		private var _resizingChildIndex : int;
		
		private var _previousChildIndex : int;
		
		private var _startSize : Number;
		
		private var _currentMousePosition : Point;
		
	}
	
}