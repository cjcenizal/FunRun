package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.KillPlayerRequest;
	import com.funrun.game.controller.events.InternalShowMainMenuRequest;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.constants.CollisionTypes;
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Command;

	public class KillPlayerCommand extends Command {

		[Inject]
		public var event:KillPlayerRequest;

		[Inject]
		public var playerModel:PlayerModel;
		
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
			eventDispatcher.dispatchEvent( new InternalShowMainMenuRequest( InternalShowMainMenuRequest.INTERNAL_SHOW_MAIN_MENU_REQUESTED ) );
		}
	}
}
