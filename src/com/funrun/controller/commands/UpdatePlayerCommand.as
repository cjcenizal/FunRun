package com.funrun.controller.commands
{
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.PlaySoundRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Sounds;
	import com.funrun.model.state.ProductionState;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdatePlayerCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var framesElapsed:int;
		
		// State.
		
		[Inject]
		public var productionState:ProductionState;
		
		// Models.
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		// Commands.
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		[Inject]
		public var killPlayerRequest:KillPlayerRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var playSoundRequest:PlaySoundRequest;
		
		override public function execute():void {
			
			// Apply ducking state.
			if ( productionState.isExploration ) {
			} else {
				if ( keyboardModel.isDown( Keyboard.DOWN ) ) {
					playerModel.isDucking = true;
					if ( playerModel.scaleY != Player.DUCKING_SCALE ) {
						playerModel.scaleY = Player.DUCKING_SCALE;
					}
				} else {
					playerModel.isDucking = false;
					if ( playerModel.scaleY != 1 ) {
						playerModel.scaleY = 1;
					}
				}
			}
			
			// Jumping.
			if ( keyboardModel.isDown( Keyboard.SPACE ) || ( !productionState.isExploration && keyboardModel.isDown( Keyboard.UP ) ) ) {
				if ( playerModel.isOnTheGround ) {
					if ( stateModel.isRunning() ) {
						playerModel.velocity.z += Player.JUMP_FORWARD_BOOST;
					}
					playerModel.velocity.y += Player.JUMP_SPEED;
					playerModel.isOnTheGround = false;
					playSoundRequest.dispatch( Sounds.JUMP );
				}
			}
			
			// Apply acceleration and velocity updates for each targeted frame.
			for ( var i:int = 0; i < framesElapsed; i++ ) {
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.velocity.x *= .6;
					playerModel.velocity.z *= .7;
				} else {
					// Update x velocity.
					playerModel.velocity.x = 0;
					if ( keyboardModel.isDown( Keyboard.LEFT ) ) {
						playerModel.velocity.x -= Player.LATERAL_SPEED;
					}
					if ( keyboardModel.isDown( Keyboard.RIGHT ) ) {
						playerModel.velocity.x += Player.LATERAL_SPEED;
					}
					
					if ( productionState.isExploration ) {
						// Explore freely, moving forward and backward.
						if ( keyboardModel.isDown( Keyboard.UP ) ) {
							playerModel.velocity.z += Player.FREE_RUN_SPEED;
						}
						if ( keyboardModel.isDown( Keyboard.DOWN ) ) {
							playerModel.velocity.z -= Player.FREE_RUN_SPEED;
						}	
						playerModel.velocity.z *= Player.FRICTION;
					} else  {
						// Move forward according to game logic.
						if ( stateModel.isRunning() ) {
							// Slow down or speed up depending on whether we're turning or not.
							if ( keyboardModel.isDown( Keyboard.LEFT ) || keyboardModel.isDown( Keyboard.RIGHT ) ) {
								if ( playerModel.velocity.z < Player.MAX_SPEED ) playerModel.velocity.z += Player.ACCELERATION;
							} else {
								if ( playerModel.velocity.z > Player.MIN_SPEED ) playerModel.velocity.z -= Player.DECELERATION;
								else if ( playerModel.velocity.z < Player.MIN_SPEED ) playerModel.velocity.z += Player.ACCELERATION;
							}
						}
					}
				}
				
				// Cap forward speed.
				if ( playerModel.velocity.z > Player.CAP_SPEED ) playerModel.velocity.z = Player.CAP_SPEED;
				
				// Update lateral position.
				playerModel.position.x += playerModel.velocity.x;
				
				// Run forward.
				playerModel.position.z += playerModel.velocity.z;
				
				// Update gravity.
				playerModel.velocity.y += Player.GRAVITY;
				playerModel.position.y += playerModel.velocity.y;
				
				// Check for falling death.
				if ( playerModel.position.y <= Player.FALL_DEATH_HEIGHT ) {
					if ( stateModel.isRunning() ) {
						killPlayerRequest.dispatch( Collisions.FALL );
					} else if ( stateModel.isWaitingForPlayers() ) {
						resetPlayerRequest.dispatch( false );
					}
				}
			}
		}
	}
}