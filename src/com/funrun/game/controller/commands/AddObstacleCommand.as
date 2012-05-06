package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.model.BlockTypes;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstacleVO;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.parsers.ObstacleParser;
	import com.funrun.game.view.components.Obstacle;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstacleCommand extends Command {
		[Inject]
		public var obstaclesModel:ObstaclesModel;

		[Inject]
		public var blocksModel:BlocksModel;

		[Inject]
		public var materialsModel:MaterialsModel;

		override public function execute():void {
			// Build an obstacle and send it to the track.
			var data:ObstacleParser = obstaclesModel.getRandomObstacle();
			try {
				var obstacle:Obstacle = new Obstacle( data.id );
				var material:ColorMaterial = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
				// Add geometry to obstacle based on data.
				var len:int = data.numBlocks;
				var blockData:ObstacleVO;
				var mesh:Mesh;
				var flip:Boolean = Math.random() < .5;
				var xAdjustment:Number = -Constants.TRACK_WIDTH * .5;
				var halfBlock:Number = Constants.BLOCK_SIZE * .5;
				for ( var i:int = 0; i < len; i++ ) {
					blockData = data.getBlockAt( i );
					mesh = getMesh( blockData.id, material );
					if ( mesh ) {
						mesh.x = blockData.x * Constants.BLOCK_SIZE + halfBlock;
						mesh.x += xAdjustment;
						mesh.y = blockData.y * Constants.BLOCK_SIZE + halfBlock;
						mesh.z = -blockData.z * Constants.BLOCK_SIZE + halfBlock;
						obstacle.addGeo( mesh );
					}
				}
				var event:AddObstacleFulfilled = new AddObstacleFulfilled( AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, obstacle );
				eventDispatcher.dispatchEvent( event );
			} catch( e:Error ) {
				trace( this, e, e.getStackTrace() );
			}
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
