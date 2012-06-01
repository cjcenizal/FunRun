package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.utils.Center;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class GameUIView extends AbstractComponent {

		// Distance.
		private var _distanceLabel:AbstractLabel;
		private var _distanceCountLabel:AbstractLabel;
		
		// Place.
		private var _placeLabel:AbstractLabel;
		private var _placeCountLabel:AbstractLabel;
		
		// Countdown.
		private var _countdownLabel:AbstractLabel;
		
		// Messages.
		public var _messagesList:MessagesList;
		
		// Quit game.
		private var _button:DummyButton;
		public var onClickQuitGameButtonSignal:Signal;
		
		public function GameUIView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function init():void {
			// Messages.
			_messagesList = new MessagesList( this );
			_messagesList.x = 170;
			_messagesList.y = stage.stageHeight - 40;
			
			// Distance.
			_distanceLabel = new AbstractLabel( this, 0, 0, "Distance", 12, 0 );
			_distanceCountLabel = new AbstractLabel( this, 0, 0, "0", 24, 0 );
			_distanceLabel.draw();
			_distanceCountLabel.draw();
			_distanceLabel.x = _distanceCountLabel.x = 20;
			_distanceCountLabel.y = stage.stageHeight - _distanceCountLabel.height - 20;
			_distanceLabel.y = _distanceCountLabel.y - _distanceLabel.height;
			
			// Place.
			_placeLabel = new AbstractLabel( this, 0, 0, "Place", 12, 0 );
			_placeCountLabel = new AbstractLabel( this, 0, 0, "0", 24, 0 );
			_placeLabel.draw();
			_placeCountLabel.draw();
			_placeLabel.x = _placeCountLabel.x = 20;
			_placeCountLabel.y = _distanceLabel.y - _distanceLabel.height - 20;
			_placeLabel.y = _placeCountLabel.y - _distanceLabel.height;
			
			// Countdown.
			_countdownLabel = new AbstractLabel( this, 0, 0, "", 110, 0xe0920b );
			
			// Quit game.
			_button = new DummyButton( this, 0, 0, onClickQuitGameButton, "Quit game", 0x0000ff, 12 );
			_button.draw();
			_button.x = stage.stageWidth - _button.width - 10;
			onClickQuitGameButtonSignal = new Signal();
		}

		public function showDistance( distance:String ):void {
			_distanceCountLabel.text = distance;
			_distanceCountLabel.draw();
		}
		
		public function showPlace( place:String ):void {
			_placeCountLabel.text = place;
			_placeCountLabel.draw();
		}
		
		public function showMessage( message:String ):void {
			_messagesList.add( message );
		}
		
		public function set countdown( message:String ):void {
			_countdownLabel.text = message;
			_countdownLabel.draw();
			Center.bothVals( _countdownLabel, stage.stageWidth, stage.stageHeight );
		}
		
		public function enableCountdown():void {
			_countdownLabel.visible = true;
		}
		
		public function disableCountdown():void {
			_countdownLabel.visible = false;
		}
		
		private function onClickQuitGameButton( e:MouseEvent ):void {
			onClickQuitGameButtonSignal.dispatch();
		}
	}
}
