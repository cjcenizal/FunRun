package com.funrun.controller.commands
{
	import com.funrun.model.KeysModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;
	
	import flash.ui.Keyboard;
	
	public class UpdatePlayerCommand extends Command
	{
		
		// State.
		
		[Inject]
		public var gameState:GameState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		override public function execute():void {
			
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
				
				// Update y velocity.
				if ( keysModel.isDown( Keyboard.SPACE ) || keysModel.isDown( Keyboard.UP ) ) {
					
					trace(playerModel.isAirborne)
					//if ( !playerModel.isAirborne ) {
						trace("jump");
						playerModel.velocity.y += Player.JUMP_SPEED;
						playerModel.isAirborne = true;
					//}
				}
				
				// Update z velocity.
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
			}
			
			// Update lateral position.
			playerModel.position.x += playerModel.velocity.x;
			
			// Run forward.
			playerModel.position.z += playerModel.velocity.z;
			
			// Update gravity.
			trace(playerModel.velocity.y);
			playerModel.velocity.y += Player.GRAVITY;
			playerModel.position.y += playerModel.velocity.y;
			if ( playerModel.position.y < 0 ) {
				playerModel.position.y = 0;
				playerModel.velocity.y = 0;
			}
			
		}
	}
}