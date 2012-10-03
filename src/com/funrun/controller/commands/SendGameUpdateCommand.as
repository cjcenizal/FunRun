package com.funrun.controller.commands {
	
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.services.GameService;
	
	import org.robotlegs.mvcs.Command;

	public class SendGameUpdateCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:GameService;
		
		override public function execute():void {
			if ( gameModel.isOnline ) {
				// Update server with position and velocity.
				multiplayerService.send(
					Messages.UPDATE,
					playerModel.position.x,
					playerModel.position.y,
					playerModel.position.z,
					playerModel.isDucking
				);
			}
		}
	}
}
