package org.goverla.dragdrop
{
	import org.goverla.controls.box.BoxWithChild;
	import org.goverla.controls.containers.CanvasWithChild;
	import org.goverla.dragdrop.interfaces.IDragView;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;

	public class DragViewBase extends CanvasWithChild implements IDragView
	{
		public function DragViewBase()
		{
			super();
			sizeByContent = true;
		}
		
		public function showError(message:String):void
		{
		}
		
		public function clearError():void
		{
		}
		
		
	}
}