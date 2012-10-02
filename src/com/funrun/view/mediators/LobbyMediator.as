package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.ClickStartGameRequest;
	import com.funrun.controller.signals.DrawLobbyChatRequest;
	import com.funrun.controller.signals.DrawLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.DrawLobbyPlayerLeftRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.SendLobbyChatRequest;
	import com.funrun.controller.signals.vo.DrawLobbyChatVo;
	import com.funrun.controller.signals.vo.DrawLobbyPlayerJoinedVo;
	import com.funrun.controller.signals.vo.DrawLobbyPlayerLeftVo;
	import com.funrun.view.components.LobbyView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LobbyMediator extends Mediator implements IMediator {
		
		// Views.
		
		[Inject]
		public var view:LobbyView;
		
		// Commands.
		
		[Inject]
		public var drawLobbyChatRequest:DrawLobbyChatRequest;
		
		[Inject]
		public var drawLobbyPlayerJoinedRequest:DrawLobbyPlayerJoinedRequest;
		
		[Inject]
		public var drawLobbyPlayerLeftRequest:DrawLobbyPlayerLeftRequest;
		
		[Inject]
		public var sendLobbyChatRequest:SendLobbyChatRequest;
		
		[Inject]
		public var clickStartGameRequest:ClickStartGameRequest;
		
		override public function onRegister():void {
			view.init();
			view.onSendChatSignal.add( onSendChat );
			view.onClickJoinGameSignal.add( onJoinGameClicked );
			drawLobbyChatRequest.add( onDrawLobbyChatRequested );
			drawLobbyPlayerJoinedRequest.add( onDrawLobbyPlayerJoinedRequested );
			drawLobbyPlayerLeftRequest.add( onDrawLobbyPlayerLeftRequested );
		}
		
		private function onSendChat():void {
			sendLobbyChatRequest.dispatch( view.getChat() );
			view.clearChat();
		}
		
		private function onJoinGameClicked():void {
			clickStartGameRequest.dispatch();
		}
		
		private function onDrawLobbyChatRequested( vo:DrawLobbyChatVo ):void {
			view.addChat( vo.source, vo.message );
		}
		
		private function onDrawLobbyPlayerJoinedRequested( vo:DrawLobbyPlayerJoinedVo ):void {
			view.addPerson( vo.id, vo.name );
		}
		
		private function onDrawLobbyPlayerLeftRequested( vo:DrawLobbyPlayerLeftVo ):void {
			view.removePerson( vo.id );
		}
	}
}
