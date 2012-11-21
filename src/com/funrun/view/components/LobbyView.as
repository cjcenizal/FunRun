package com.funrun.view.components {
	
	import com.bit101.components.InputText;
	import com.bit101.components.List;
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.utils.Center;
	import com.funrun.view.components.ui.ChatList;
	import com.funrun.view.components.ui.FunButton;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	public class LobbyView extends AbstractComponent {
		
		[Embed (source="embed/home_bg.jpg" )]
		private var Background:Class;

		[Embed (source="embed/join_game_button.jpg" )]
		private var JoinGameButton:Class;
		
		[Embed (source="embed/join_game_button_hover.jpg" )]
		private var JoinGameButtonHover:Class;
		
		// Data.
		
		private var _people:Object = {};
		
		// UI.
		
		private var _bg:Bitmap;
		private var _title:AbstractLabel;
		private var _chatList:ChatList;
		private var _peopleList:List;
		private var _input:InputText;
		private var _joinGameButton:FunButton;
		private var _leaveLobbyButton:DummyButton;
		
		// Signals.
		
		public var onSendChatSignal:Signal;
		public var onClickJoinGameSignal:Signal;
		public var onClickLeaveSignal:Signal;
		
		public function LobbyView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			visible = false;
		}
		
		public function init():void {
			onSendChatSignal = new Signal();
			onClickJoinGameSignal = new Signal();
			onClickLeaveSignal = new Signal();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			// Background.
			_bg = new Background();
			addChild( _bg );
			
			// Title.
			_title = new AbstractLabel( this, 0, 0, "Lobby", 18 );
			_title.draw();
			Center.horizontal( _title, stage );
			
			// Leave button.
			_leaveLobbyButton = new DummyButton( this, 0, 0, onClickLeave, "Main menu", 0x0000ff, 12 );
			_leaveLobbyButton.draw();
			_leaveLobbyButton.x = stage.stageWidth - _leaveLobbyButton.width - 10;
			
			// Lists.
			var peopleListWidth:Number = 140;
			var listHeight:Number = 400;
			_chatList = new ChatList( this, 0, 0 );
			_chatList.draw();
			
			_peopleList = new List( this, 0, 0 );
			_peopleList.width = peopleListWidth;
			_peopleList.height = listHeight;
			_peopleList.x = _chatList.x + _chatList.width;
			
			_chatList.y = _peopleList.y = 40;
			_chatList.draw();
			
			// Input.
			_input = new InputText( this, 0, _chatList.y + _chatList.height + 10 );
			_input.maxChars = 80;
			_input.width = 400;
			_input.height = 30;
			_input.draw();
			Center.horizontal( _input, stage );
			_input.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			// Start game button.
			_joinGameButton = new FunButton( this, 350, 310, onClickJoinGame );
			_joinGameButton.setImages( new JoinGameButton(), new JoinGameButtonHover() );
			_joinGameButton.rotation = .3;
			
		}
		
		private function onClickLeave( e:MouseEvent ):void {
			onClickLeaveSignal.dispatch();
		}
		
		private function onClickJoinGame( e:MouseEvent ):void {
			onClickJoinGameSignal.dispatch();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			if ( e.keyCode == Keyboard.ENTER ) {
				onSendChatSignal.dispatch();
			}
		}
		
		public function addChat( source:String, message:String ):void {
			_chatList.addItem( source + ": " + message );
		}
		
		public function addPerson( id:String, name:String ):void {
			if ( !_people[ id ] ) {
				_people[ id ] = new LobbyPerson( id, name );
				_peopleList.addItem( _people[ id ] );
			}
		}
		
		public function removePerson( id:String ):void {
			if ( _people[ id ] ) {
				_peopleList.removeItem( _people[ id ] );
				delete _people[ id ];
			}
		}
		
		public function getChat():String {
			return _input.text;
		}
		
		public function clearChat():void {
			_input.text = "";
		}
	}
}
