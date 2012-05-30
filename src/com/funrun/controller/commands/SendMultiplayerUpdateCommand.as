package com.funrun.controller.commands {
	
	import com.funrun.model.DistanceModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.MessageTypes;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;

	public class SendMultiplayerUpdateCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		override public function execute():void {
			// Update server with position and velocity.
			multiplayerService.send(
				MessageTypes.UPDATE,
				playerModel.player.x,
				playerModel.player.y,
				distanceModel.rawDistance,
				playerModel.velocity.x,
				playerModel.velocity.y,
				playerModel.velocity.z
			);
		}
	}
}