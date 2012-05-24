package com.funrun.services.parsers
{
	import flash.display.DisplayObject;
	
	public class ConfigurationMockParser implements IConfigurationParser
	{
		public function ConfigurationMockParser()
		{
		}
		
		public function configure(root:DisplayObject):void
		{
		}
		
		public function get playerioGameId():String
		{
			return null;
		}
		
		public function get fbAppId():String
		{
			return null;
		}
		
		public function get fbAccessToken():String
		{
			return null;
		}
	}
}