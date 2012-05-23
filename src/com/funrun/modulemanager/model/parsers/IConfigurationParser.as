package com.funrun.modulemanager.model.parsers {
	
	import flash.display.DisplayObject;
	
	public interface IConfigurationParser {
		
		function configure( root:DisplayObject ):void;
		function get playerioGameId():String;
		function get fbAppId():String;
		function get fbAccessToken():String;
	}
}
