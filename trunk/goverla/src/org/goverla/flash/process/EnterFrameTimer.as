package org.goverla.flash.process {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.Application;
	
	import org.goverla.events.EventSender;
	
	public class EnterFrameTimer {
		
		private var _tick : EventSender = new EventSender();
		private var _dispatcher : EventDispatcher;
		private var _framesPerTick : uint;
		private var _frameNumber : uint = 0;
		
		public function EnterFrameTimer(framesPerTick : uint = 1, dispatcher : DisplayObject = null) {
			_framesPerTick = framesPerTick;
			_dispatcher = dispatcher == null ? EventDispatcher(Application.application) : dispatcher;
			
		}
		
		public function get framesPerTick() : uint
		{
			return _framesPerTick
		}
		
		public function set framesPerTick(value : uint) : void
		{
			_framesPerTick = value;
		}
		
		
		public function get tick() : EventSender
		{
			return _tick;
		}
		
		public function start() : void {
			_dispatcher.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function stop() : void {
			_dispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function sendTick() : void
		{
			tick.sendEvent();
		}
		
		private function onEnterFrame(event : Event) : void {
			_frameNumber++;
			if (_framesPerTick == _frameNumber) {
				_frameNumber = 0;
				sendTick();
			}
			
		}
		

	}
	
}