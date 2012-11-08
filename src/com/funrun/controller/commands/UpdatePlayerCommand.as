package com.funrun.controller.commands
{
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.PlaySoundRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Sounds;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdatePlayerCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var framesElapsed:int;
		
		// State.
		
		[Inject]
		public var productionState:GameModel;
		
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
			var duckingKey:uint = ( productionState.isExploration ) ? Keyboard.D : Keyboard.DOWN;
			if ( keyboardModel.isDown( duckingKey ) ) {
				playerModel.isDucking = true;
				//if ( playerModel.scaleY != Player.DUCKING_SCALE ) {
				//	playerModel.scaleY = Player.DUCKING_SCALE;
				//}
			} else {
				playerModel.isDucking = false;
				//if ( playerModel.scaleY != 1 ) {
				//	playerModel.scaleY = 1;
				//}
			}
			
			// Jumping.
			if ( keyboardModel.isDown( Keyboard.SPACE ) || ( !productionState.isExploration && keyboardModel.isDown( Keyboard.UP ) ) ) {
				if ( playerModel.canJump ) {
					if ( playerModel.isOnTheGround ) {
						playSoundRequest.dispatch( Sounds.JUMP );
					}
					//if ( stateModel.canMoveForward ) {
					//	playerModel.velocity.z += Player.JUMP_FORWARD_BOOST;
					//}
					playerModel.velocity.y += Player.JUMP_SPEEDS[ playerModel.jump() ];
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
					var left:Boolean = keyboardModel.isDown( Keyboard.LEFT );
					var right:Boolean = keyboardModel.isDown( Keyboard.RIGHT );
					if ( ( left && right ) || ( !left && !right ) ) {
						playerModel.velocity.x = 0;
					} else if ( left ) {
						playerModel.velocity.x -= Player.LATERAL_SPEED;
					} else if ( right ) {
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
					} else {
						if ( stateModel.canMoveForward ) {
							if ( playerModel.velocity.z < Player.MAX_SPEED ) {
								playerModel.velocity.z += Player.ACCELERATION;
							}
						}
					}
				}
				
				// Cap forward speed.
				if ( playerModel.velocity.z > Player.SPEED_CAP ) playerModel.velocity.z = Player.SPEED_CAP;
				
				// Update lateral position.
				playerModel.position.x += playerModel.velocity.x;
				
				// Run forward.
				playerModel.position.z += playerModel.velocity.z;
				
				// Update gravity.
				playerModel.velocity.y += Player.GRAVITY;
				playerModel.position.y += playerModel.velocity.y;
				
				// Check for falling death.
				if ( playerModel.position.y <= Player.FALL_DEATH_HEIGHT ) {
					if ( stateModel.canDie ) {
						killPlayerRequest.dispatch( Collisions.FALL );
					} else {
						resetPlayerRequest.dispatch( false );
					}
				}
			}
		}
	}
}