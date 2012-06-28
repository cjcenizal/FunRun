package com.funrun.controller.signals.payload
{
	import org.osflash.signals.Signal;

	public class AddDelayedCommandPayload
	{
		
		public var signal:Signal;
		public var delayMs:int;
		public var arg:*;
		public var type:Class;
		
		public function AddDelayedCommandPayload( signal:Signal, delayMs:int, arg:* = null, type:Class = null )
		{
			this.signal = signal;
			this.delayMs = delayMs;
			this.arg = arg;
			this.type = type;
		}
	}
}