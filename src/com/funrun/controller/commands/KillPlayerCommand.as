	package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddDelayedCommandRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.payload.AddDelayedCommandPayload;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
	import com.funrun.model.state.ExplorationState;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		// Arguments.
		
		[Inject]
		public var death:String;
		
		// State.
		
		[Inject]
		public var explorationState:ExplorationState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var endRoundRequest:EndRoundRequest;
		
		[Inject]
		public var sendMultiplayerDeathRequest:SendMultiplayerDeathRequest;
		
		[Inject]
		public var startObserverLoopRequest:StartObserverLoopRequest;
		
		[Inject]
		public var addDelayedCommandRequest:AddDelayedCommandRequest;
		
		override public function execute():void {
			if ( !playerModel.isDead ) {
				// Update the model.
				if ( !explorationState.isFree ) {
					playerModel.isDead = true;
				}
				switch ( death ) {
					case Collisions.SMACK:
						playerModel.velocity.z = Player.HEAD_ON_SMACK_SPEED;
						break;
					case Collisions.FALL:
						break;
				}
				// Update server.
				sendMultiplayerDeathRequest.dispatch();
				
				// TO-DO: Wait before we take action on the death.
				
				// If there are any surviving competitors, observe them.
				if ( !explorationState.isFree ) {
					if ( competitorsModel.numLiveCompetitors > 0 ) {
						addDelayedCommandRequest.dispatch( new AddDelayedCommandPayload( startObserverLoopRequest, 1500 ) );
					} else {
						addDelayedCommandRequest.dispatch( new AddDelayedCommandPayload( endRoundRequest, 1500 ) );
					}
				}
			}
		}
	}
}
