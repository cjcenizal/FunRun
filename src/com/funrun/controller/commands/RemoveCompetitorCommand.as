package com.funrun.controller.commands {

	import com.funrun.controller.signals.RemoveNametagRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemovePlaceableRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;

	public class RemoveCompetitorCommand extends Command {

		// Arguments.

		[Inject]
		public var competitor:CompetitorVo;
		
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
		
		[Inject]
		public var removePlaceableRequest:RemovePlaceableRequest;
		
		override public function execute():void {
			// Remove mesh.
			removeObjectFromSceneRequest.dispatch( competitor.mesh );
			competitorsModel.remove( competitor.id );
			// Remove nametag.
			removeNametagRequest.dispatch( nametagsModel.getWithId( competitor.id.toString() ) );
			nametagsModel.remove( competitor.id );
			// Remove placeable.
			removePlaceableRequest.dispatch( competitor );
		}
	}
}
