package com.funrun.modulemanager.model.parsers
{
	import flash.display.DisplayObject;
	
	public class ConfigurationParser implements IConfigurationParser
	{
		public function ConfigurationParser()
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