package com.funrun.controller.commands {

	import com.funrun.controller.signals.RemoveNametagRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;

	public class RemoveCompetitorCommand extends Command {

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
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var removeNametagRequest:RemoveNametagRequest;
		
		override public function execute():void {
			// Remove mesh.
			removeObjectFromSceneRequest.dispatch( competitor.mesh );
			// Remove nametag.
			removeNametagRequest.dispatch( nametagsModel.getWithId( competitor.id.toString() ) );
			// Remove from models.
			competitorsModel.remove( competitor.id );
			nametagsModel.remove( competitor.id );
		}
	}
}
