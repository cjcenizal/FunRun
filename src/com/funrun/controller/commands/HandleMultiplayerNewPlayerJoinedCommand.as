package com.funrun.controller.commands {

	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerNewPlayerJoinedCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			if ( message.getInt( 0 ) != multiplayerService.playerRoomId ) {
				var mesh:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
				mesh.x = message.getNumber( 1 );
				mesh.y = message.getNumber( 2 );
				mesh.z = distanceModel.getRelativeDistanceTo( message.getNumber( 3 ) );
				competitorsModel.add( new CompetitorVO(
					message.getInt( 0 ),
					mesh,
					new Vector3D( message.getNumber( 4 ), message.getNumber( 5 ), message.getNumber( 6 ) ),
					false,
					false ) );
				addObjectToSceneRequest.dispatch( mesh );
			}
		}
	}
}
