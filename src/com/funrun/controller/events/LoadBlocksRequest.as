package com.funrun.controller.events
{
	import flash.events.Event;
	
	public class LoadBlocksRequest extends Event
	{
		public static const LOAD_BLOCKS_REQUESTED:String = "LoadBlocksRequest.LOAD_BLOCKS_REQUESTED";
		
		public function LoadBlocksRequest( type:String ) {
			super( type );
		}
	}
}