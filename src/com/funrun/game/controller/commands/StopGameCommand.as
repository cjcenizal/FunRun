package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.StopGameRequest;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StopGameCommand extends Command {

		[Inject]
		public var event:StopGameRequest;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;

		override public function execute():void {
			// Stop responding to time.
			commandMap.unmapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Stop responding to input.
			commandMap.unmapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.unmapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
		}
	}
}
