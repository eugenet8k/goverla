package org.goverla.process.threading
{
	import org.goverla.process.EnterFrameTimer;
	import org.goverla.process.events.ThreadFinishEvent;
	import org.goverla.process.events.ThreadProcessEvent;
	import org.goverla.process.interfaces.IThread;
	import org.goverla.errors.NotImplementedError;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;

	public class TimeLimitThread extends EventDispatcher implements IThread
	{
		private var _timer : EnterFrameTimer;
		private var _timeLimit : uint;
		private var _started : Boolean;
		private var _restart : Boolean;
		private var _ignoreTimeLimit : Boolean;
		
		public function TimeLimitThread(timeLimit : uint) {
			_timeLimit = timeLimit;
			_timer = new EnterFrameTimer(1);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		public function get ignoreTimeLimit() : Boolean {
			return _ignoreTimeLimit;
		}
		
		public function set ignoreTimeLimit(value : Boolean) : void {
			_ignoreTimeLimit = value;
		}
		
		public function finish() : void
		{
			
		}
		
		public function process() : void
		{

		}
		
		public function start() : void
		{
			if(!_started) {
				_started = true;
				_timer.start();
				doProcess();
			} else {
				_restart = true;
			}
		}
		
		public function hasToFinish() : Boolean {
			throw new NotImplementedError("hasToFinish is abstract");
		}
		
		private function doProcess() : void {
			var startTime : Date = new Date();
			var timeLimitExceeded : Boolean;
			var count : uint = 0;
			do {
				count++;
				process();
				dispatchEvent(new ThreadProcessEvent());
				timeLimitExceeded = new Date().getTime() - startTime.getTime() > _timeLimit;
				timeLimitExceeded = timeLimitExceeded && !ignoreTimeLimit;
			} while(!hasToFinish() && !timeLimitExceeded);
			if(hasToFinish()) {
				doFinish();
			}
		}
		
		private function doFinish() : void {
			_timer.stop();
			_started = false;
			finish();
			dispatchEvent(new ThreadFinishEvent());
			if(_restart) {
				_restart = false;
				start();
			}
		}
		
		private function onTimer(event : TimerEvent) : void {
			if(hasToFinish()) {
				doFinish();
			} else {
				doProcess();
			}
		}
		
		

	}
}