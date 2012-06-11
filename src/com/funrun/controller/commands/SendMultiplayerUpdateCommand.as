package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.MessageTypes;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.MultiplayerService;
	
	import org.robotlegs.mvcs.Command;

	public class SendMultiplayerUpdateCommand extends Command {
		
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
				// Update server with position and velocity.
				multiplayerService.send(
					MessageTypes.UPDATE,
					playerModel.positionX,
					playerModel.positionY,
					playerModel.positionZ,
					playerModel.isDucking
				);
			}
		}
	}
}
