package com.funrun.model.vo
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