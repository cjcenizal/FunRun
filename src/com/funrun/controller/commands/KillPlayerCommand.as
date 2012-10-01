	package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddDelayedCommandRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.ShakeCameraRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
	import com.funrun.controller.signals.vo.AddDelayedCommandVo;
	import com.funrun.controller.signals.vo.ShakeCameraVo;
	
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
		
		[Inject]
		public var shakeCameraRequest:ShakeCameraRequest;
		
		override public function execute():void {
			if ( !playerModel.isDead ) {
				// Update the model.
				playerModel.isDead = true;
				switch ( death ) {
					case Collisions.SMACK:
						playerModel.velocity.z = Player.HEAD_ON_SMACK_SPEED;
						shakeCameraRequest.dispatch( new ShakeCameraVo( 100, 100, 100, 1 ) );
						break;
					case Collisions.FALL:
						break;
				}
				// Update server.
				sendMultiplayerDeathRequest.dispatch();
				
				// If there are any surviving competitors, observe them.
				if ( competitorsModel.numLiveCompetitors > 0 ) {
					addDelayedCommandRequest.dispatch( new AddDelayedCommandVo( startObserverLoopRequest, 1500 ) );
				} else {
					addDelayedCommandRequest.dispatch( new AddDelayedCommandVo( endRoundRequest, 1500 ) );
				}
			}
		}
	}
}
