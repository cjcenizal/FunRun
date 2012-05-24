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
			playerModel.isAirborne = true;
			playerModel.isDucking = false;
			playerModel.isJumping = false;
			playerModel.cancelMovement();
			playerModel.speed = playerModel.lateralVelocity = 0;
			playerModel.jumpVelocity = 50;
			playerModel.player.position = new Vector3D( Math.random() * 100, 100, 0 );
		}
	}
}
