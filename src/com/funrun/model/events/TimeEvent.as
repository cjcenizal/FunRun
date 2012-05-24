package com.funrun.model.events
{
	import flash.events.Event;
	
	public class TimeEvent extends Event
	{
		public static const TICK:String = "TimeEvent.TICK";
		
		public var ticks:int;
		public var delta:int;
		public var ts:int;
		
		public function TimeEvent( type:String, ticks:int, delta:int, ts:int )
		{
			super( type );
			this.ticks = ticks;
			this.delta = delta;
			this.ts = ts;
		}
	}
}