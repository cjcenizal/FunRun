package com.funrun.controller.commands {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var stopGameLoopRequest:StopGameLoopRequest;
		
		override public function execute():void {
			// Stop game loop.
			stopGameLoopRequest.dispatch();
			
			// Move nametags out of the way.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVo;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				nametag = nametagsModel.getWithId( competitor.id.toString() );
				if ( nametag ) {
					nametag.x = -500;
				}
			}
			
			// Set up observer.
			observerModel.reset();
			
			// Set camera.
			view3dModel.ease.x = .1;
			view3dModel.ease.y = .1;
			view3dModel.ease.z = .1;
			view3dModel.easeHover = .5;
			view3dModel.setTargetPerspective( 25, view3dModel.tiltAngle, view3dModel.distance );
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
		}
	}
}
