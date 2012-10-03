package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.GameService;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendGameDeathCommand extends Command {
		
		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:GameService;
		
		override public function execute():void {
			if ( onlineState.isOnline ) {
				multiplayerService.send(
					Messages.DEATH,
					playerModel.position.x,
					playerModel.position.y,
					playerModel.position.z
				);
			}
		}
	}
}
