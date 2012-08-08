package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Track;
	
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
			var width:Number = Track.WIDTH * .8;
			playerModel.positionX = Math.random() * width;
			playerModel.positionY = 300;
			playerModel.positionZ = Math.random() * 100;
			playerModel.updateMeshPosition();
		}
	}
}
