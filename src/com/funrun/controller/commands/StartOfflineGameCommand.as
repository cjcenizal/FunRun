package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddAiCompetitorsRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.PlayerProperties;
	
	import org.robotlegs.mvcs.Command;

	public class StartOfflineGameCommand extends Command {

		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;

		[Inject]
		public var startRunningRequest:StartRunningRequest;

		[Inject]
		public var addAiCompetitorsRequest:AddAiCompetitorsRequest;

		override public function execute():void {
			var key:String, val:*;
			for ( var i:int = 0; i < PlayerProperties.KEYS.length; i++ ) {
				key = PlayerProperties.KEYS[ i ];
				playerModel.properties[ key ] = PlayerProperties.DEFAULTS[ key ];
			}
			startGameLoopRequest.dispatch();
			startRunningRequest.dispatch();
			addAiCompetitorsRequest.dispatch( 0 );
		}
	}
}
