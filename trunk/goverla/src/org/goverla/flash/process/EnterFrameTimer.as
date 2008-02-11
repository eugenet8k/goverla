package org.goverla.flash.process {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	
	import mx.core.Application;
	
	public class EnterFrameTimer extends EventDispatcher {
		
		public function EnterFrameTimer(framesPerTick : uint) {
			_framesPerTick = framesPerTick;
		}
		
		public function start() : void {
			Application.application.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function stop() : void {
			Application.application.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event : Event) : void {
			_frameNumber++;
			if (_framesPerTick == _frameNumber) {
				_frameNumber = 0;
				dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			}
			
		}
		
		private var _framesPerTick : uint;
		
		private var _frameNumber : uint = 0;

	}
	
}