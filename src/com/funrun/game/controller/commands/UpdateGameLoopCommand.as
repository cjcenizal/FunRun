package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGameLoopCommand extends Command
	{
		[Inject]
		public var trackModel:TrackModel;
		
		override public function execute():void {
			trace("update");
			
			// Update obstacles.
			trackModel.move( -Constants.MAX_PLAYER_FORWARD_VELOCITY );
			
			
			if ( trackModel.numObstacles > 0 ) {
				var mesh:Mesh = trackModel.getObstacleAt( 0 );
				if ( mesh.z < -600 ) {
					// dispatch a RemoveObstacleFromSceneRequest
					//		_scene.removeChild( mesh );
					trackModel.removeObstacleAt( 0 );
				}
			}
			
			if ( trackModel.numObstacles > 0 ) {
				trackModel.addZ = trackModel.getObstacleAt( trackModel.numObstacles - 1 ).z;
			}
			while ( trackModel.addZ < Constants.TRACK_LENGTH + Constants.BLOCK_SIZE ) {
				// Add obstacles to fill up track.
				//dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
			}
			
			
			// Update player.
			
			// Update camera.
			
		}
	}
}