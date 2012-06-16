package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.LoginFulfilled;
	import com.funrun.controller.signals.WhitelistFailed;
	import com.funrun.model.PlayerModel;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	public class CheckWhitelistCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var whitelistService:IWhitelistService;
		
		// Commands.
		
		[Inject]
		public var whitelistFailed:WhitelistFailed;
		
		[Inject]
		public var loginFulfilled:LoginFulfilled;
		
		override public function execute():void {
			whitelistService.onPassSignal.add( onPass );
			whitelistService.onFailSignal.add( onFail );
			whitelistService.isIdInTable( playerModel.userId, "Whitelist", loginService.client );
		}
		
		private function onPass():void {
			loginFulfilled.dispatch();
		}
		
		private function onFail():void {
			whitelistFailed.dispatch();
		}
	}
}
