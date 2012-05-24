package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddPlayerCommand extends Command {
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			var player:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
			playerModel.player = player;
			addObjectToSceneRequest.dispatch( player );
		}
	}
}
