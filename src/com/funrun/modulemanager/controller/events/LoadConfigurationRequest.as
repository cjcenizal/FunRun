package com.funrun.modulemanager.controller.events {
	
	import flash.events.Event;
	
	public class LoadConfigurationRequest extends Event {
		
		public static const LOAD_CONFIGURATION_REQUESTED:String = "LoadConfigurationRequest.LOAD_CONFIGURATION_REQUESTED";
		
		public function LoadConfigurationRequest( type:String ) {
			super( type );
		}
	}
}
