package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.GeosModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstacleVO;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.view.Obstacle;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstacleCommand extends Command {
		[Inject]
		public var obstaclesModel:ObstaclesModel;

		[Inject]
		public var geosModel:GeosModel;

		[Inject]
		public var materialsModel:MaterialsModel;

		override public function execute():void {
			// Build an obstacle and send it to the track.
			var data:ObstacleVO = obstaclesModel.getRandomObstacle();
			var obstacle:Obstacle = new Obstacle( data.id );
			var material:ColorMaterial = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );

			// Add geometry to obstacle based on VO.
			var mesh:Mesh;
			var flip:Boolean = Math.random() < .5;
			var colLen:int = ( data.geos[ 0 ] as Array ).length;
			var rowLen:int = data.geos.length;
			var xAdjustment:Number = ( ( colLen - 1 ) * Constants.BLOCK_SIZE ) * .5;
			for ( var col:int = 0; col < colLen; col++ ) {
				for ( var row:int = 0; row < rowLen; row++ ) {
					mesh = getMesh( data.geos[ row ][ col ], material );
					if ( mesh ) {
						var meshX:Number = ( flip ) ? ( colLen - 1 - col ) : col;
						meshX *= Constants.BLOCK_SIZE;
						meshX -= xAdjustment;
						var meshY:Number = mesh.bounds.max.y * .5;
						var meshZ:Number = ( rowLen - 1 - row ) * Constants.BLOCK_SIZE;
						mesh.position = new Vector3D( meshX, meshY, meshZ );
						obstacle.addGeo( mesh );
					}
				}
			}

			var event:AddObstacleFulfilled = new AddObstacleFulfilled( AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, obstacle );
			eventDispatcher.dispatchEvent( event );
		}

		private function getMesh( geo:String, material:ColorMaterial ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case "empty":  {
					mesh = null;
					break;
				}
				case "ledge":  {
					mesh = new Mesh( geosModel.getGeo( geosModel.LEDGE_GEO ), material );
					break;
				}
				case "wall":  {
					mesh = new Mesh( geosModel.getGeo( geosModel.WALL_GEO ), material );
					break;
				}
				case "beam":  {
					mesh = new Mesh( geosModel.getGeo( geosModel.BEAM_GEO ), material );
					break;
				}
			}
			return mesh;
		}
	}
}
