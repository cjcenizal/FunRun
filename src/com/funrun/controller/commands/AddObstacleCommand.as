package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var index:int;
		
		// Models.
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			// Get an obstacle.
			var obstacle:ObstacleData = obstaclesModel.getAt( index );
			trackModel.addObstacle( obstacle );
			// Add to view.
			addObjectToSceneRequest.dispatch( obstacle.mesh );
		}
	}
}
