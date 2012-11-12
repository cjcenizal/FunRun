package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.model.ColorsModel;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;


	public class AddCompetitorCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var competitor:CompetitorVo;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var colorsModel:ColorsModel;
		
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
				var color:uint = colorsModel.getColorAt( Math.floor( Math.random() * colorsModel.numColors ) );
				var material:ColorMaterial = materialsModel.getColorMaterial( color );
				var mesh:Mesh = new Mesh( new CubeGeometry( Player.NORMAL_BOUNDS.x, Player.NORMAL_BOUNDS.y, Player.NORMAL_BOUNDS.z ), material );
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
				competitor.hardUpdatePosition();
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
