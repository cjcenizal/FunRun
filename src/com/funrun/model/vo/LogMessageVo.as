package com.funrun.model.vo
{
	public class LogMessageVo
	{
		
		public var source:*;
		public var message:String;
		
		public function LogMessageVo( source:*, message:String )
		{
			this.source = source;
			this.message = message;
		}
	}
}