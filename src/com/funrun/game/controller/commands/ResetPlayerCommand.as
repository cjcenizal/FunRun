package com.funrun.game.controller.commands {
	
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class ResetPlayerCommand extends Command {
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			playerModel.isDead = false;
			playerModel.isAirborne = false;
			playerModel.isDucking = false;
			playerModel.isJumping = false;
			playerModel.speed = playerModel.jumpVelocity = playerModel.lateralVelocity = 0;
			playerModel.player.position = new Vector3D( 0, TrackConstants.PLAYER_HALF_SIZE, 0 );
		}
	}
}
