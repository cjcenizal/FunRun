package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddPlayerCommand extends Command {
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		override public function execute():void {
			var player:Mesh = new Mesh( new CylinderGeometry( 40, 50, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
			player.position = new Vector3D( 0, TrackConstants.PLAYER_HALF_SIZE, 0 );
			playerModel.player = player;
			eventDispatcher.dispatchEvent( new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, player ) );
		}
	}
}
