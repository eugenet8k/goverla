package org.goverla.flash.playback {
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	
	import org.goverla.events.EventSender;
	import org.goverla.flash.playback.events.IntervalEndEvent;
	import org.goverla.flash.process.EnterFrameTimer;
	
	public class MovieClipPlayer {
		
		public function MovieClipPlayer(movie : MovieClip) {
			_movie = movie;
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public function get intervalEnd() : EventSender {
			return _intervaleEnd;
		}
		
		public function playInterval(start : uint, end : uint) : void {
			_currentFrame = start;
			_movie.gotoAndStop(start);
			_difference = (start > end) ? -1 : 1;
			_end = end;
			_timer.start();
		}
		
		private function onTimer(event : TimerEvent) : void {
			if (_movie.currentFrame != _currentFrame || _currentFrame == _end) {
				_timer.stop();
				intervalEnd.sendEvent(new IntervalEndEvent());
			} else {
				_currentFrame += _difference;
				_movie.gotoAndStop(_currentFrame);
			}
		}
		
		private var _intervaleEnd : EventSender = new EventSender(IntervalEndEvent);
		
		private var _movie : MovieClip;
		
		private var _timer : EnterFrameTimer = new EnterFrameTimer(1);
		
		private var _difference : int;
		
		private var _currentFrame : uint;
		
		private var _end : uint;

	}
	
}