package com.funrun.controller.commands
{
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendLobbyChatCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var message:String;
		
		// Services.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var lobbyService:LobbyService;
		
		override public function execute():void
		{
			lobbyService.send( Messages.CHAT, playerModel.name, message );
		}
	}
}