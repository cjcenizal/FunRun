package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.SendGameUpdateRequest;
	import com.funrun.controller.signals.UpdateCollisionsRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdatePlayerRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.UpdateUiRequest;
	import com.funrun.controller.signals.UpdateViewRequest;
	import com.funrun.controller.signals.vo.UpdateTrackVo;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGameLoopCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var timeEvent:TimeEvent;
		
		// Models.
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var stateModel:StateModel;
		
		// Commands.
		
		[Inject]
		public var updatePlayerRequest:UpdatePlayerRequest;
		
		[Inject]
		public var updateCollisionsRequest:UpdateCollisionsRequest;
		
		[Inject]
		public var updateViewRequest:UpdateViewRequest;
		
		[Inject]
		public var updateCompetitorsRequest:UpdateCompetitorsRequest;
		
		[Inject]
		public var updateUiRequest:UpdateUiRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var sendMultiplayerUpdateRequest:SendGameUpdateRequest;
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		override public function execute():void {
			
		//	switch ( gameModel.state ) {
		//		case GameModel.READY_TO_RUN:
					// Target 30 frames per second and move the player.
					var framesElapsed:int = 1;//Math.round( .03 * timeEvent.delta );
					updatePlayerRequest.dispatch( framesElapsed );
					updateCollisionsRequest.dispatch();
		//			break;
		//		case GameModel.WAITING_FOR_READY:
		//			break;
		//	}
			
			updateTrackRequest.dispatch( new UpdateTrackVo( playerModel.distance ) );
			
			updateViewRequest.dispatch();
			
			updateCompetitorsRequest.dispatch();
			
			renderSceneRequest.dispatch();
			
			updateUiRequest.dispatch();
			
			sendMultiplayerUpdateRequest.dispatch();
		}
	}
}
