package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Player;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;


	public class AddCompetitorCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var competitor:CompetitorVO;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addNametagRequest:AddNametagRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		override public function execute():void {
			// Avoid adding accidental duplicates.
			if ( !competitorsModel.getWithId( competitor.id ) ) {
				// Add mesh.
				var mesh:Mesh = new Mesh( new CubeGeometry( Player.NORMAL_BOUNDS.x, Player.NORMAL_BOUNDS.y, Player.NORMAL_BOUNDS.z ), Materials.DEBUG_PLAYER );
				competitor.mesh = mesh;
				if ( competitor.isDucking ) {
					if ( competitor.mesh.scaleY != .25 ) {
						competitor.mesh.scaleY = .25;
					}
				} else {
					if ( competitor.mesh.scaleY != 1 ) {
						competitor.mesh.scaleY = 1;
					}
				}
				competitor.hardUpdate();
				competitorsModel.add( competitor );
				addObjectToSceneRequest.dispatch( mesh );
				// Add nametag.
				var nametag:AbstractLabel = new AbstractLabel( null, 0, 0, competitor.name );
				nametagsModel.add( competitor.id, nametag );
				addNametagRequest.dispatch( nametag );
				addPlaceableRequest.dispatch( competitor );
			}
		}
	}
}
