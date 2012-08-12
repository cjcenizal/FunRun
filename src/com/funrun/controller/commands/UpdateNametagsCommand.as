package com.funrun.controller.commands {

	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateNametagsCommand extends Command {

		// Models.

		[Inject]
		public var competitorsModel:CompetitorsModel;

		[Inject]
		public var nametagsModel:NametagsModel;

		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var view3DModel:View3DModel;
		
		// Commands.

		[Inject]
		public var updateAiCompetitorsRequest:UpdateAiCompetitorsRequest;


		override public function execute():void {

			// Interpolate competitor position.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVO;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				// Only show nametag if the competitor is in front of the player.
				nametag = nametagsModel.getWithId( competitor.id.toString() );
				if ( nametag ) {
					if ( playerModel.position.z - competitor.position.z < 300 ) {
						var pos:Point = view3DModel.project( competitor.mesh.position );
						nametag.x = pos.x;
						nametag.y = pos.y;
					} else {
						nametag.x = -500;
					}
				}
			}

		}
	}
}
