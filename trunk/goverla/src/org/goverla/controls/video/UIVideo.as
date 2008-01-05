package org.goverla.controls.video
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.managers.ISystemManager;

	public class UIVideo extends UIComponent 
	{
		private var _video : Video;
		
		public function UIVideo()
		{
			_video = new Video(640, 480);
			//_video.width = _video.height = 200;
			addChild(_video);
			//BindingUtils.bindProperty(_video, "width", this, "width");
			//BindingUtils.bindProperty(_video, "height", this, "height");
		}
		
		public function attachNetStream(netStream : NetStream) : void
		{
			_video.attachNetStream(netStream);
		}

		public function attachCamera(camera : Camera) : void
		{
			_video.attachCamera(camera);
		}
		
		override public function setActualSize(w:Number, h:Number):void
		{
			_video.width = w;
			_video.height = h;
			
		}
	}
}