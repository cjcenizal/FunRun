	package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.CollisionTypes;
	import com.funrun.model.constants.TrackConstants;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		// Arguments.
		
		[Inject]
		public var death:String;

		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var endRoundRequest:EndRoundRequest;
		
		[Inject]
		public var sendMultiplayerDeathRequest:SendMultiplayerDeathRequest;
		
		[Inject]
		public var stopGameLoopRequest:StopGameLoopRequest;
		
		[Inject]
		public var startObserverLoopRequest:StartObserverLoopRequest;
		
		// Private vars.
		
		private var _timer:Timer;
		
		override public function execute():void {
			if ( !playerModel.isDead ) {
				// Update the model.
				playerModel.isDead = true;
				switch ( death ) {
					case CollisionTypes.SMACK:
						playerModel.velocityZ = TrackConstants.HEAD_ON_SMACK_SPEED;
						break;
					case CollisionTypes.FALL:
						trace(this, "Fell to death");
						break;
				}
				// Update server.
				sendMultiplayerDeathRequest.dispatch();
				// Wait before we take action on the death.
				_timer = new Timer( 1500, 1 );
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimer );
				_timer.start();
			}
		}
		
		private function onTimer( e:TimerEvent ):void {
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimer );
			_timer.stop();
			_timer = null;
			stopGameLoopRequest.dispatch();
			// If there are any surviving competitors, observe them.
			if ( competitorsModel.numLiveCompetitors > 0 ) {
				startObserverLoopRequest.dispatch();
			} else {
				endRoundRequest.dispatch();
			}
		}
	}
}
