package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.MultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendMultiplayerDeathCommand extends Command {
		
		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:MultiplayerService;
		
		override public function execute():void {
			if ( onlineState.isOnline ) {
				multiplayerService.send(
					Messages.DEATH,
					playerModel.positionX,
					playerModel.positionY,
					playerModel.positionZ
				);
			}
		}
	}
}
