package com.funrun.controller.signals.vo
{
	public class DrawLobbyChatVo
	{
		
		public var source:String;
		public var message:String;
		
		public function DrawLobbyChatVo( source:String, message:String )
		{
			this.source = source;
			this.message = message;
		}
	}
}