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
			playerModel.velocity.z = playerModel.velocity.x = 0;
			playerModel.velocity.y = 50;
			var width:Number = TrackConstants.TRACK_WIDTH * .8;
			playerModel.mesh.position = new Vector3D( Math.random() * width - width * .5, 100, 0 );
		}
	}
}
