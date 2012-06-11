package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.TrackConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class ResetPlayerCommand extends Command {
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			playerModel.isDead = false;
			playerModel.isAirborne = true;
			playerModel.isDucking = false;
			playerModel.isJumping = false;
			playerModel.cancelMovement();
			playerModel.velocityZ = playerModel.velocityX = 0;
			playerModel.velocityY = 50;
			var width:Number = TrackConstants.TRACK_WIDTH * .8;
			playerModel.positionX = Math.random() * width - width * .5;
			playerModel.positionY = 100;
			playerModel.updateMeshPosition( playerModel.positionX, playerModel.positionY, 0 );
		}
	}
}
