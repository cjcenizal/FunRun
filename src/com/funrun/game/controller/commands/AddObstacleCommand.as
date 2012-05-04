package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.model.GeosModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstacleVO;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.view.Obstacle;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command
	{
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
			obstacle.addGeo( getMesh( "ledge", material ) );
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