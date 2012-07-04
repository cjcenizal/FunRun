package com.funrun.model.state
{
	public class LoginState
	{
		public static const LOGGING_IN:String = "Logging in...";
		public static const CONNECTING_TO_FB:String = "Connecting to FB...";
		public static const PLAYERIO_FAILURE:String = "Sorry, our servers barfed! Please try again later.";
		public static const WHITELIST_FAILURE:String = "We're currently in private beta, sorry!";
		public static const LOGIN_SUCCESS:String = "";
		
		public static var isComplete:Boolean = false;
	}
}