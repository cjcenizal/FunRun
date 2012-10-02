package com.funrun.view.components
{
	public class LobbyPerson
	{
		
		public var id:String;
		public var name:String;
		
		public function LobbyPerson( id:String, name:String )
		{
			this.id = id;
			this.name = name;
		}
		
		public function toString():String {
			return name;
		}
	}
}