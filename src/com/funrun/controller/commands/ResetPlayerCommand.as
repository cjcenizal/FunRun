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
			playerModel.isOnTheGround = false;
			playerModel.isDucking = true;// false;
			playerModel.velocity.z = playerModel.velocity.x = 0;
			playerModel.velocity.y = 0;//100;
			var width:Number = Track.WIDTH * .8;
			playerModel.position.x = 0;//Math.random() * width;
			playerModel.position.y = 300;
			playerModel.position.z = 300;//Math.random() * 100;
			playerModel.updateMeshPosition();
		}
	}
}
