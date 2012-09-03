package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class AccountModel extends Actor
	{
		public function AccountModel()
		{
			super();
		}
		
		public function owns( id:String ):Boolean {
			return false;
		}
		
		public function wears( id:String ):Boolean {
			return false;
		}
	}
}