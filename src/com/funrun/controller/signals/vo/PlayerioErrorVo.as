package com.funrun.controller.signals.vo
{
	import playerio.PlayerIOError;

	public class PlayerioErrorVo
	{
		
		public var error:PlayerIOError;
		
		public function PlayerioErrorVo( error:PlayerIOError )
		{
			this.error = error;
		}
	}
}