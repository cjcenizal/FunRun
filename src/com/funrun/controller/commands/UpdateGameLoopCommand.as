package com.funrun.controller.commands {
	
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;
	
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateCollisionsRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateNametagsRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.controller.signals.UpdatePlayerRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.Camera;
	import com.funrun.model.constants.Player;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGameLoopCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var timeEvent:TimeEvent;
		
		// State.
		
		[Inject]
		public var gameState:GameState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		[Inject]
		public var updatePlayerRequest:UpdatePlayerRequest;
		
		[Inject]
		public var updateCollisionsRequest:UpdateCollisionsRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var sendMultiplayerUpdateRequest:SendMultiplayerUpdateRequest;
		
		[Inject]
		public var updateCompetitorsRequest:UpdateCompetitorsRequest;
		
		[Inject]
		public var updateNametagsRequest:UpdateNametagsRequest;
		
		[Inject]
		public var updatePlacesRequest:UpdatePlacesRequest;
		
		override public function execute():void {
			
			// Update countdown if necessary.
			if ( gameState.gameState == GameState.WAITING_FOR_PLAYERS ) {
				if ( countdownModel.isRunning ) {
					if ( countdownModel.secondsRemaining > 0 ) {
						updateCountdownRequest.dispatch( countdownModel.secondsRemaining.toString() );
					} else {
						// Start running.
						startRunningRequest.dispatch();
					}
				}
			}
			
			// Target 30 frames per second.
			var framesElapsed:int = Math.round( .03 * timeEvent.delta );
			trace("===========================================================");
			//for ( var f:int = 0; f < framesElapsed; f++ ) {
			//	trace("frame",f);
				if ( gameState.gameState == GameState.RUNNING ) {
					// Update obstacles.
					updateTrackRequest.dispatch( new UpdateTrackPayload( playerModel.distance ) );
				}
				
				// Move player.
				updatePlayerRequest.dispatch();
				
				// Detect collisions.
				updateCollisionsRequest.dispatch();
			//}
			
			// Update camera before updating competitors.
			view3DModel.cameraX = playerModel.position.x;
			var followFactor:Number = ( Camera.Y + playerModel.position.y < view3DModel.cameraY ) ? .3 : .1;
			// We'll try easing to follow the player instead of being locked.
			view3DModel.cameraY += ( ( Camera.Y + playerModel.position.y ) - view3DModel.cameraY ) * followFactor;
			view3DModel.cameraZ += ( ( playerModel.position.z + Camera.Z ) - view3DModel.cameraZ ) * .65;
			view3DModel.update();
			
			// Update light.
			var light:LightBase = lightsModel.getLight( LightsModel.SPOTLIGHT );
			light.z = playerModel.position.z;
			
			// Set position to mesh.
			playerModel.updateMeshPosition();
			
			// Update competitors' positions.
			updateCompetitorsRequest.dispatch();
			
			// Update nametags.
			updateNametagsRequest.dispatch();
			
			// Update distance counter.
			if ( gameState.gameState == GameState.RUNNING ) {
				displayDistanceRequest.dispatch( playerModel.distanceString + " feet" );
			}
			
			// Update other players with our position.
			sendMultiplayerUpdateRequest.dispatch();
			
			// Update places.
			updatePlacesRequest.dispatch();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
