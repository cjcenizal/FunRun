package com.funrun.model.vo {

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.Signal;

	public class DelayedCommandVO {

		private var _timer:Timer;
		public var callback:Function;

		public function DelayedCommandVO( delayMs:int, callback:Function ) {
			this.callback = callback;
			_timer = new Timer( delayMs );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			_timer.start();
		}

		private function onTimerComplete( e:TimerEvent ):void {
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			_timer = null;
			callback( this );
			callback = null;
		}
		
		public function destroy():void {
			if ( _timer ) {
				_timer.stop();
				_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
				_timer = null;
			}
			callback = null;
		}
	}
}
