package com.funrun.controller.commands {
	
	import com.funrun.controller.events.KillPlayerRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.CollisionTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.state.ScreenState;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		[Inject]
		public var event:KillPlayerRequest;

		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		private var _timer:Timer;
		
		override public function execute():void {
			if ( !playerModel.isDead ) {
				playerModel.isDead = true;
				switch ( event.death ) {
					case CollisionTypes.SMACK:
						playerModel.speed = TrackConstants.HEAD_ON_SMACK_SPEED;
						break;
					case CollisionTypes.FALL:
						trace(this, "Fell to death");
						break;
				}
				_timer = new Timer( 1500, 1 );
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimer );
				_timer.start();
			}
		}
		
		private function onTimer( e:TimerEvent ):void {
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimer );
			_timer.stop();
			_timer = null;
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
		}
	}
}
