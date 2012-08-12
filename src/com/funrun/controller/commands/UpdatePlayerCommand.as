package com.funrun.controller.commands
{
	import com.funrun.model.KeysModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.state.ExplorationState;
	import com.funrun.model.state.GameState;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdatePlayerCommand extends Command
	{
		
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
				
				// Explore.
				if ( explorationState.isFree ) {
					if ( keysModel.isDown( Keyboard.UP ) ) {
						playerModel.velocity.z += 10;
					}
					if ( keysModel.isDown( Keyboard.DOWN ) ) {
						playerModel.velocity.z -= 10;
					}	
					playerModel.velocity.z *= .9;
				}
				
				// Move forward according to game logic.
				if ( !explorationState.isFree ) {
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
				}
				
				// Jumping.
				if ( keysModel.isDown( Keyboard.SPACE ) || ( !explorationState.isFree && keysModel.isDown( Keyboard.UP ) ) ) {
					if ( playerModel.isOnTheGround ) {
						playerModel.velocity.y += Player.JUMP_SPEED;
						playerModel.isOnTheGround = false;
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
			
			// Update lateral position.
			playerModel.position.x += playerModel.velocity.x;
			
			// Run forward.
			playerModel.position.z += playerModel.velocity.z;
			
			// Update gravity.
			playerModel.velocity.y += Player.GRAVITY;
			playerModel.position.y += playerModel.velocity.y;
		}
	}
}