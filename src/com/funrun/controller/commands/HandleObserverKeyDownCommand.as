package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.FollowNewCompetitorRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ObserverModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class HandleObserverKeyDownCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var followNewCompetitorRequest:FollowNewCompetitorRequest;
		
		override public function execute():void {
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
					followNewCompetitorRequest.dispatch( 1 );
				case Keyboard.UP:
					followNewCompetitorRequest.dispatch( 1 );
					break;
				case Keyboard.LEFT:
					followNewCompetitorRequest.dispatch( -1 );
					break;
				case Keyboard.RIGHT:
					followNewCompetitorRequest.dispatch( 1 );
					break;
				case Keyboard.DOWN:
					followNewCompetitorRequest.dispatch( -1 );
					break;
			}
		}
	}
}
