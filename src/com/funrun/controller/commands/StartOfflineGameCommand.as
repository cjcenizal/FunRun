package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddAiCompetitorsRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.model.GameModel;
	
	import org.robotlegs.mvcs.Command;

	public class StartOfflineGameCommand extends Command {

		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// State.
		
		[Inject]
		public var productionState:GameModel;
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;

		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		[Inject]
		public var startCountdownRequest:StartCountdownRequest;
		
		[Inject]
		public var addAiCompetitorsRequest:AddAiCompetitorsRequest;

		override public function execute():void {
			var key:String, val:*;
			for ( var i:int = 0; i < PlayerProperties.KEYS.length; i++ ) {
				key = PlayerProperties.KEYS[ i ];
				playerModel.properties[ key ] = PlayerProperties.DEFAULTS[ key ];
			}
			if ( productionState.isExploration ) {
				startRunningRequest.dispatch();
			} else {
				startCountdownRequest.dispatch( 3000 );
			}
			startGameLoopRequest.dispatch();
			addAiCompetitorsRequest.dispatch( Player.NUM_AI_COMPETITORS );
		}
	}
}
