package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Track;
	
	import org.robotlegs.mvcs.Command;
	
	public class ResetPlayerCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var doResetState:Boolean;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			if ( doResetState ) {
				playerModel.isDead = false;
				playerModel.isOnTheGround = false;
				playerModel.isDucking = false;
			}
			playerModel.velocity.z = 0;
			playerModel.velocity.x = 0;
			playerModel.velocity.y = 100;
			var width:Number = Track.WIDTH * .8;
			playerModel.position.x = Math.random() * width +  Track.WIDTH * .1;
			playerModel.position.y = 100;
			playerModel.position.z = Math.random() * Player.START_POSITION_RANGE + Player.START_POSITION_MIN;
			playerModel.updatePosition();
		}
	}
}
