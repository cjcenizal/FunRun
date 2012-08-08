	package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddDelayedCommandRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.payload.AddDelayedCommandPayload;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Track;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		// Arguments.
		
		[Inject]
		public var death:String;

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
				playerModel.isDead = true;
				switch ( death ) {
					case Collisions.SMACK:
						playerModel.velocityZ = Track.HEAD_ON_SMACK_SPEED;
						break;
					case Collisions.FALL:
						trace(this, "Fell to death");
						break;
				}
				// Update server.
				sendMultiplayerDeathRequest.dispatch();
				// Wait before we take action on the death.
				
				// If there are any surviving competitors, observe them.
				if ( competitorsModel.numLiveCompetitors > 0 ) {
					addDelayedCommandRequest.dispatch( new AddDelayedCommandPayload( startObserverLoopRequest, 1500 ) );
				} else {
					addDelayedCommandRequest.dispatch( new AddDelayedCommandPayload( endRoundRequest, 1500 ) );
				}
			}
		}
	}
}
