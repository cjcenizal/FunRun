package com.funrun.model.vo
{
	import playerio.PlayerIOError;

	public class PlayerioErrorVO
	{
		
		public var error:PlayerIOError;
		
		public function PlayerioErrorVO( error:PlayerIOError )
		{
			this.error = error;
		}
	}
}