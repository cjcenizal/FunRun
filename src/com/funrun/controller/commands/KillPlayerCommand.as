	package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.ShowResultsPopupRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.CollisionTypes;
	import com.funrun.model.constants.TrackConstants;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		[Inject]
		public var death:String;

		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var showResultsPopupRequest:ShowResultsPopupRequest;
		
		[Inject]
		public var sendMultiplayerDeathRequest:SendMultiplayerDeathRequest;
		
		private var _timer:Timer;
		
		override public function execute():void {
			if ( !playerModel.isDead ) {
				// Update the model.
				playerModel.isDead = true;
				switch ( death ) {
					case CollisionTypes.SMACK:
						playerModel.velocity.z = TrackConstants.HEAD_ON_SMACK_SPEED;
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
			showResultsPopupRequest.dispatch();
		}
	}
}
