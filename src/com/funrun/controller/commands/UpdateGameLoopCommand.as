package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.controller.signals.UpdatePlayerCollisionsRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	import com.funrun.model.state.OnlineState;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateGameLoopCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var timeEvent:TimeEvent;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var view3DModel:View3DModel;

		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var gameModel:GameModel;
		
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
		public var updatePlayerCollisionsRequest:UpdatePlayerCollisionsRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var sendMultiplayerUpdateRequest:SendMultiplayerUpdateRequest;
		
		[Inject]
		public var updateCompetitorsRequest:UpdateCompetitorsRequest;
		
		[Inject]
		public var updatePlacesRequest:UpdatePlacesRequest;
		
		override public function execute():void {
			// Update countdown if necessary.
			if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
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
			for ( var f:int = 0; f < framesElapsed; f++ ) {
				if ( gameModel.gameState == GameState.RUNNING ) {
					// Update obstacles.
					updateTrackRequest.dispatch( new UpdateTrackPayload( playerModel.distance ) );
				}
	
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.velocityX *= .6;
					playerModel.velocityZ *= .7;
				} else {
					if ( gameModel.gameState == GameState.RUNNING ) {
						// Update speed when you're alive.
						if ( Math.abs( playerModel.velocityX ) > 0 ) {
							if ( playerModel.velocityZ > TrackConstants.SLOWED_DIAGONAL_SPEED ) {
								playerModel.velocityZ--;
							}
						} else if ( playerModel.velocityZ < TrackConstants.MAX_PLAYER_FORWARD_VELOCITY ) {
							playerModel.velocityZ += TrackConstants.PLAYER_FOWARD_ACCELERATION;
						}
					}
					// Update jumping.
					if ( playerModel.isJumping && !playerModel.isAirborne ) {
						playerModel.velocityY += TrackConstants.PLAYER_JUMP_SPEED;
						playerModel.isAirborne = true;
					}
					// Update lateral position.
					playerModel.positionX += playerModel.velocityX;
				}
				
				// Run forward.
				playerModel.positionZ += playerModel.velocityZ;
	
				// Update gravity.
				playerModel.velocityY += TrackConstants.PLAYER_GRAVITY;
				playerModel.positionY += playerModel.velocityY;
				
				// Apply ducking state.
				if ( playerModel.isDucking ) {
					if ( playerModel.scaleY != .25 ) {
						playerModel.scaleY = .25;
						playerModel.bounds.min.y *= .25;
						playerModel.bounds.max.y *= .25;
					}
				} else {
					if ( playerModel.scaleY != 1 ) {
						playerModel.scaleY = 1;
						playerModel.bounds.min.y /= .25;
						playerModel.bounds.max.y /= .25;
					}
				}
				
				// Detect collisions.
				updatePlayerCollisionsRequest.dispatch();
			}
			
			// Set position to mesh.
			playerModel.updateMeshPosition();
			
			// TO-DO: Update lights.
			
			// Update competitors' positions.
			updateCompetitorsRequest.dispatch();
			
			// Update distance counter.
			// TO-DO: Fix this so that a maxDistance var is stored inside PlayerModel.
			if ( gameModel.gameState == GameState.RUNNING ) {
				displayDistanceRequest.dispatch( playerModel.distanceString + " feet" );
			}
			
			// Update other players with our position.
			sendMultiplayerUpdateRequest.dispatch();
			
			// Update places.
			updatePlacesRequest.dispatch();
			
			// Update camera.
			view3DModel.cameraX = playerModel.positionX;
			var followFactor:Number = ( TrackConstants.CAM_Y + playerModel.positionY < view3DModel.cameraY ) ? .3 : .1;
			// We'll try easing to follow the player instead of being locked.
			view3DModel.cameraY += ( ( TrackConstants.CAM_Y + playerModel.positionY ) - view3DModel.cameraY ) * followFactor;
			view3DModel.cameraZ += ( ( playerModel.positionZ + TrackConstants.CAM_Z ) - view3DModel.cameraZ ) * .65;
			view3DModel.update();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
