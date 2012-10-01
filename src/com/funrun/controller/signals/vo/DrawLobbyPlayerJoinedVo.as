package com.funrun.controller.signals.vo
{
	public class DrawLobbyPlayerJoinedVo
	{
		public var name:String;
		public var id:String;
		
		public function DrawLobbyPlayerJoinedVo( name:String, id:String )
		{
			this.name = name;
			this.id = id;
		}
	}
}