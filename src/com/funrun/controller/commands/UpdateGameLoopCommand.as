package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateObstaclesRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.controller.signals.UpdatePlayerCollisionsRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	
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
		public var distanceModel:DistanceModel;
		
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
		public var updateObstaclesRequest:UpdateObstaclesRequest;
		
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
					updateObstaclesRequest.dispatch();
				}
	
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.velocity.x *= .6;
					playerModel.velocity.z *= .7;
				} else {
					if ( gameModel.gameState == GameState.RUNNING ) {
						// Store distance.
						distanceModel.add( playerModel.velocity.z );
						// Update speed when you're alive.
						if ( Math.abs( playerModel.velocity.x ) > 0 ) {
							if ( playerModel.velocity.z > TrackConstants.SLOWED_DIAGONAL_SPEED ) {
								playerModel.velocity.z--;
							}
						} else if ( playerModel.velocity.z < TrackConstants.MAX_PLAYER_FORWARD_VELOCITY ) {
							playerModel.velocity.z += TrackConstants.PLAYER_FOWARD_ACCELERATION;
						}
					}
					// Update jumping.
					if ( playerModel.isJumping && !playerModel.isAirborne ) {
						playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
						playerModel.isAirborne = true;
					}
					// Update lateral position.
					playerModel.mesh.x += playerModel.velocity.x;
				}
	
				// Update gravity.
				playerModel.velocity.y += TrackConstants.PLAYER_GRAVITY;
				playerModel.mesh.y += playerModel.velocity.y;
				
				// Apply ducking state.
				if ( playerModel.isDucking ) {
					if ( playerModel.mesh.scaleY != .25 ) {
						playerModel.mesh.scaleY = .25;
						playerModel.mesh.bounds.min.y *= .25;
						playerModel.mesh.bounds.max.y *= .25;
					}
				} else {
					if ( playerModel.mesh.scaleY != 1 ) {
						playerModel.mesh.scaleY = 1;
						playerModel.mesh.bounds.min.y /= .25;
						playerModel.mesh.bounds.max.y /= .25;
					}
				}
				
				// Detect collisions.
				updatePlayerCollisionsRequest.dispatch();
	
				// Update camera.
				view3DModel.cameraX = playerModel.mesh.x;
				var followFactor:Number = ( TrackConstants.CAM_Y + playerModel.mesh.y < view3DModel.cameraY ) ? .3 : .1;
				// We'll try easing to follow the player instead of being locked.
				view3DModel.cameraY += ( ( TrackConstants.CAM_Y + playerModel.mesh.y ) - view3DModel.cameraY ) * followFactor;
				view3DModel.cameraZ = -1000;
				view3DModel.update();
			}
			
			// Update competitors' positions.
			updateCompetitorsRequest.dispatch();
			
			// Update distance counter.
			if ( gameModel.gameState == GameState.RUNNING ) {
				displayDistanceRequest.dispatch( distanceModel.distanceString + " feet" );
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
