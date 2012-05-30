package com.funrun.controller.commands {

	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.NametagsModel;
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
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addNametagRequest:AddNametagRequest;
		
		override public function execute():void {
			if ( message.getInt( 0 ) != multiplayerService.playerRoomId ) {
				var mesh:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
				mesh.x = message.getNumber( 2 );
				mesh.y = message.getNumber( 3 );
				mesh.z = distanceModel.getRelativeDistanceTo( message.getNumber( 4 ) );
				var competitor:CompetitorVO = new CompetitorVO(
					message.getInt( 0 ),
					message.getString( 1 ),
					mesh,
					new Vector3D( message.getNumber( 5 ), message.getNumber( 6 ), message.getNumber( 7 ) ),
					false,
					false
				);
				competitorsModel.add( competitor );
				addObjectToSceneRequest.dispatch( mesh );
				// Add nametag.
				var nametag:AbstractLabel = new AbstractLabel( null, 0, 0, competitor.name );
				nametagsModel.add( competitor.id, nametag );
				addNametagRequest.dispatch( nametag );
			}
		}
	}
}
