package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.UserModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerJoinGameCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var joinGameRequest:JoinGameRequest;
		
		override public function execute():void {
			var roomIdToJoin:String = message.getString( 0 );
			var obstacleSeed:Number = message.getInt( 1 );
			var remainingMsInCountdown:Number = message.getNumber( 2 );
			
			// Store random seed.
			obstaclesModel.seed = obstacleSeed;
			
			// Initialize countdown.
			countdownModel.secondsRemaining = remainingMsInCountdown;
			toggleCountdownRequest.dispatch( true );
			
			// Connect to game.
			joinGameRequest.dispatch( roomIdToJoin );
		}
	}
}
