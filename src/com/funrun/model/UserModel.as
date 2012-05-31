package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;

	public class UserModel extends Actor {
		
		public var userId:String;
		public var name:String;
		public var inGameId:int = -1;
		
		public function UserModel() {
			super();
		}
		
		public function resetInGameId():void {
			inGameId = -1;
		}
	}
}
