package com.funrun.model.vo {

	import org.osflash.signals.Signal;

	public class AddDelayedCommandVo {

		public var signal:Signal;
		public var delayMs:int;
		public var arg:*;
		public var type:Class;

		public function AddDelayedCommandVo( signal:Signal, delayMs:int, arg:* = null, type:Class = null ) {
			this.signal = signal;
			this.delayMs = delayMs;
			this.arg = arg;
			this.type = type;
		}
	}
}
