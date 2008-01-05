package skins
{
	import flash.events.Event;
	import mx.core.IFlexDisplayObject;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;

	public class BaseSkin extends MovieClip implements IFlexDisplayObject
	{
		public function BaseSkin()
		{
			super();
		}
		
		public function get measuredHeight():Number
		{
			return height;
		}
		public function setActualSize(newWidth:Number, newHeight:Number):void
		{
			width = newWidth;
			height = newHeight;
		}
		
		public function get measuredWidth():Number
		{
			return width;
		}
		
		public function move(x : Number, y : Number) : void
		{
			this.x = x;
			this.y = y;
		}
		
	}
}