package com.funrun.controller.commands {
	
	import away3d.lights.LightBase;
	
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawDistanceRequest;
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
		
		// Commands.
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		[Inject]
		public var updatePlayerRequest:UpdatePlayerRequest;
		
		[Inject]
		public var updateCollisionsRequest:UpdateCollisionsRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var drawDistanceRequest:DrawDistanceRequest;
		
		[Inject]
		public var sendMultiplayerUpdateRequest:SendMultiplayerUpdateRequest;
		
		[Inject]
		public var updateCompetitorsRequest:UpdateCompetitorsRequest;
		
		[Inject]
		public var updateNametagsRequest:UpdateNametagsRequest;
		
		[Inject]
		public var updatePlacesRequest:UpdatePlacesRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		override public function execute():void {
			
			// Target 30 frames per second and move the player.
			var framesElapsed:int = Math.round( .03 * timeEvent.delta );
			updatePlayerRequest.dispatch( framesElapsed );
				
			// Detect collisions.
			updateCollisionsRequest.dispatch();
			
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
				drawDistanceRequest.dispatch( playerModel.distanceString + " feet" );
			}
			
			// Update countdown if necessary.
			if ( gameState.gameState == GameState.WAITING_FOR_PLAYERS ) {
				updateCountdownRequest.dispatch();
			}
			
			// Update places.
			updatePlacesRequest.dispatch();
			
			// Render.
			renderSceneRequest.dispatch();
			
			// Update other players with our position.
			sendMultiplayerUpdateRequest.dispatch();
			
		}
	}
}
