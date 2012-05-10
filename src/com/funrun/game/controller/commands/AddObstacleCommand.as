package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.model.BlockTypes;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstacleCommand extends Command {
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;

		[Inject]
		public var blocksModel:BlocksModel;

		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var trackModel:TrackModel;

		override public function execute():void {
			// Get an obstacle.
			var obstacle:Mesh = obstaclesModel.getRandomObstacle().clone() as Mesh;
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				var lastObstacle:Mesh = trackModel.getObstacleAt( numObstacles - 1 );
				obstacle.z = lastObstacle.z + lastObstacle.bounds.max.z * 2 + 500;
			} else {
				obstacle.z = Constants.TRACK_LENGTH
			}
			trackModel.addZ = obstacle.z;
			trackModel.addObstacle( obstacle );
			// Add to view.
			// Change this to dispatch AddObstacleToSceneRequest
			var event:AddObstacleFulfilled = new AddObstacleFulfilled( AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, obstacle );
			eventDispatcher.dispatchEvent( event );
		}
	
		private function getMesh( geo:String, material:ColorMaterial ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case BlockTypes.EMPTY:  {
					mesh = null;
					break;
				}
				case BlockTypes.BLOCK:  {
					mesh = new Mesh( blocksModel.getBlock( BlockTypes.BLOCK ).geo, material );
					break;
				}
			}
			return mesh;
		}
		
	}
}
