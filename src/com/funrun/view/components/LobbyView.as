package com.funrun.view.components {
	
	import com.bit101.components.InputText;
	import com.bit101.components.List;
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.utils.Center;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	public class LobbyView extends AbstractComponent {
		
		// UI.
		
		private var _title:AbstractLabel;
		private var _chatList:List;
		private var _peopleList:List;
		private var _input:InputText;
		
		// Signals.
		
		public var onSendChatSignal:Signal;
		
		public function LobbyView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			visible = false;
		}
		
		public function init():void {
			onSendChatSignal = new Signal();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			// Background.
			var g:Graphics = this.graphics;
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			// Title.
			_title = new AbstractLabel( this, 0, 0, "Lobby", 18 );
			_title.draw();
			_title.x = ( stage.stageWidth - _title.width ) * .5;
			
			// Lists.
			_chatList = new List( this, 0, 0 );
			_chatList.width = stage.stageWidth - 120;
			_chatList.height = 400;
			_chatList.draw();
			
			_peopleList = new List( this, 0, 0 );
			_peopleList.width = 120;
			_peopleList.height = 400;
			_peopleList.x = _chatList.x + _chatList.width;
			
			_chatList.y = _peopleList.y = 40;
			_chatList.draw();
			
			// Input.
			_input = new InputText( this, 0, _chatList.y + _chatList.height + 10 );
			_input.maxChars = 80;
			_input.width = 400;
			_input.height = 30;
			_input.draw();
			_input.x = ( stage.stageWidth - _input.width ) * .5;
			_input.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			if ( e.keyCode == Keyboard.ENTER ) {
				onSendChatSignal.dispatch();
			}
		}
		
		public function addChat( source:String, message:String ):void {
			_chatList.addItem( source + ": " + message );
		}
		
		public function addPerson( name:String ):void {
			_peopleList.addItem( name );
		}
		
		public function removePerson( name:String ):void {
			_peopleList.removeItem( name );
		}
		
		public function getChat():String {
			return _input.text;
		}
		
		public function clearChat():void {
			_input.text = "";
		}
	}
}
