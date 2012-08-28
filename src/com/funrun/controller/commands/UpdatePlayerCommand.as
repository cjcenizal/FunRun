package com.funrun.controller.commands
{
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.KeysModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.state.ExplorationState;
	import com.funrun.model.state.GameState;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdatePlayerCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var framesElapsed:int;
		
		// State.
		
		[Inject]
		public var gameState:GameState;
		
		[Inject]
		public var explorationState:ExplorationState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		override public function execute():void {
			
			for ( var i:int = 0; i < framesElapsed; i++ ) {
				
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.velocity.x *= .6;
					playerModel.velocity.z *= .7;
				} else {
					// Update x velocity.
					playerModel.velocity.x = 0;
					if ( keysModel.isDown( Keyboard.LEFT ) ) {
						playerModel.velocity.x -= Player.LATERAL_SPEED;
					}
					if ( keysModel.isDown( Keyboard.RIGHT ) ) {
						playerModel.velocity.x += Player.LATERAL_SPEED;
					}
					
					if ( explorationState.isFree ) {
						// Explore freely, moving forward and backward.
						if ( keysModel.isDown( Keyboard.UP ) ) {
							playerModel.velocity.z += Player.FREE_RUN_SPEED;
						}
						if ( keysModel.isDown( Keyboard.DOWN ) ) {
							playerModel.velocity.z -= Player.FREE_RUN_SPEED;
						}	
						playerModel.velocity.z *= Player.FRICTION;
					} else  {
						// Move forward according to game logic.
						if ( gameState.gameState == GameState.RUNNING ) {
							// Update speed when you're alive.
							if ( Math.abs( playerModel.velocity.x ) > 0 ) {
								if ( playerModel.velocity.z > Player.SLOWED_DIAGONAL_SPEED ) {
									playerModel.velocity.z--;
								}
							} else if ( playerModel.velocity.z < Player.MAX_FORWARD_VELOCITY ) {
								playerModel.velocity.z += Player.FOWARD_ACCELERATION;
							}
						}
						
						// Apply ducking state.
						if ( keysModel.isDown( Keyboard.DOWN ) ) {
							playerModel.isDucking = true;
							if ( playerModel.scaleY != .25 ) {
								playerModel.scaleY = .25;
							}
						} else {
							playerModel.isDucking = false;
							if ( playerModel.scaleY != 1 ) {
								playerModel.scaleY = 1;
							}
						}
					}
					
					// Jumping.
					if ( keysModel.isDown( Keyboard.SPACE ) || ( !explorationState.isFree && keysModel.isDown( Keyboard.UP ) ) ) {
						if ( playerModel.isOnTheGround ) {
							playerModel.velocity.y += Player.JUMP_SPEED;
							playerModel.isOnTheGround = false;
						}
					}
					
				}
				// Update lateral position.
				playerModel.position.x += playerModel.velocity.x;
				
				// Run forward.
				playerModel.position.z += playerModel.velocity.z;
				
				// Update gravity.
				playerModel.velocity.y += Player.GRAVITY;
				playerModel.position.y += playerModel.velocity.y;
			}
			
			if ( gameState.gameState == GameState.RUNNING ) {
				// Update obstacles.
				updateTrackRequest.dispatch( new UpdateTrackPayload( playerModel.distance ) );
			}
		}
	}
}