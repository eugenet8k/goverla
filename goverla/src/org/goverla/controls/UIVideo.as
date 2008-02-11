package org.goverla.controls {
	
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import mx.core.UIComponent;

	public class UIVideo extends UIComponent {
		
		public function UIVideo() {
			super();
			_video = new Video(640, 480);
			addChild(_video);
		}
		
		public function attachNetStream(netStream : NetStream) : void {
			_video.attachNetStream(netStream);
		}

		public function attachCamera(camera : Camera) : void {
			_video.attachCamera(camera);
		}
		
		override public function setActualSize(w : Number, h : Number):void {
			_video.width = w;
			_video.height = h;
		}
		
		private var _video : Video;
		
	}
	
}