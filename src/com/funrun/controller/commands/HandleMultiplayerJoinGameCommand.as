package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.ObstaclesModel;
	
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
		public var joinGameRequest:JoinGameRequest;
		
		override public function execute():void {
			var roomIdToJoin:String = message.getString( 0 );
			var obstacleSeed:Number = message.getInt( 1 );
			var remainingMsInCountdown:Number = message.getNumber( 2 );
			
			// Store random seed.
			obstaclesModel.seed = obstacleSeed;
			
			// Connect to game.
			joinGameRequest.dispatch( roomIdToJoin );
		}
	}
}