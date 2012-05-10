package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.RemoveObstacleFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGameLoopCommand extends Command
	{
		[Inject]
		public var trackModel:TrackModel;
		
		override public function execute():void {
			
			// Update obstacles.
			trackModel.move( -Constants.MAX_PLAYER_FORWARD_VELOCITY );
			
			// Remove obstacles from end of track.
			if ( trackModel.numObstacles > 0 ) {
				var mesh:Mesh = trackModel.getObstacleAt( 0 );
				while ( mesh.z < -600 ) {
					eventDispatcher.dispatchEvent( new RemoveObstacleFromSceneRequest( RemoveObstacleFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, mesh ) );
					trackModel.removeObstacleAt( 0 );
					mesh = trackModel.getObstacleAt( 0 );
				}
			}
			
			// Update position at which to add new obstacles.
			if ( trackModel.numObstacles > 0 ) {
				trackModel.addZ = trackModel.getObstacleAt( trackModel.numObstacles - 1 ).z;
			}
			// Add new obstacles.
			while ( trackModel.addZ < Constants.TRACK_LENGTH + Constants.BLOCK_SIZE ) {
				// Add obstacles to fill up track.
				eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
			}
			
			
			// Update player.
			
			// Update camera.
			
			
			// Render.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}
	}
}