package com.funrun.modulemanager.events
{
	import flash.events.Event;
	
	public class ReturnToMainMenuRequest extends Event
	{
		
		public static const RETURN_TO_MAIN_MENU_REQUESTED:String = "ReturnToMainMenuRequest.RETURN_TO_MAIN_MENU_REQUESTED";
		
		public function ReturnToMainMenuRequest(type:String)
		{
			super(type);
		}
	}
}