package com.funrun.controller.signals.payload
{
	import org.osflash.signals.Signal;

	public class AddDelayedCommandPayload
	{
		
		public var signal:Signal;
		public var delayMs:int;
		public var args:Array;
		
		public function AddDelayedCommandPayload( signal:Signal, delayMs:int, ...args )
		{
			this.signal = signal;
			this.delayMs = delayMs;
			this.args = args;
		}
	}
}