package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	public class StopGameCommand extends Command {
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;

		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		override public function execute():void {
			// Stop responding to time.
			commandMap.unmapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Stop responding to input.
			enablePlayerInputRequest.dispatch( false );
			// Disconnect from server.
			multiplayerService.disconnect();
		}
	}
}
