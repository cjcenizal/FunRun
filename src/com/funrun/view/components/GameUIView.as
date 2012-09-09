package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.utils.Center;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class GameUIView extends AbstractComponent {

		// Points.
		private var _pointsCountLabel:AbstractLabel;
		private var _pointsLabel:AbstractLabel;
		
		// Speed.
		private var _speedCountLabel:AbstractLabel;
		private var _speedLabel:AbstractLabel;
		
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
			
			// Points.
			_pointsLabel = new AbstractLabel( this, 0, 0, "Points", 12, 0 );
			_pointsCountLabel = new AbstractLabel( this, 0, 0, "0", 24, 0 );
			_pointsLabel.draw();
			_pointsCountLabel.draw();
			_pointsCountLabel.x = 10;
			_pointsCountLabel.y = 0;
			_pointsLabel.y = _pointsCountLabel.y + _pointsCountLabel.height - _pointsLabel.height - 3;
			
			// Speed.
			_speedLabel = new AbstractLabel( this, 0, 0, "MPH", 12, 0 );
			_speedCountLabel = new AbstractLabel( this, 0, 0, "0", 24, 0 );
			_speedLabel.draw();
			_speedCountLabel.draw();
			_speedCountLabel.x = 10;
			_speedCountLabel.y = 0;
			_speedLabel.y = _speedCountLabel.y + _speedCountLabel.height - _speedLabel.height - 3;
			
			// Countdown.
			_countdownLabel = new AbstractLabel( this, 0, 0, "", 110, 0xe0920b );
			
			// Quit game.
			_button = new DummyButton( this, 0, 0, onClickQuitGameButton, "Quit game", 0x0000ff, 12 );
			_button.draw();
			_button.x = stage.stageWidth - _button.width - 10;
			onClickQuitGameButtonSignal = new Signal();
		}

		public function drawPoints( val:Number ):void {
			_pointsCountLabel.text = val.toString();
			_pointsCountLabel.draw();
			_pointsLabel.x = _pointsCountLabel.x + _pointsCountLabel.width;
			_speedCountLabel.x = _pointsLabel.x + _pointsLabel.width + 20;
		}
		
		public function drawSpeed( val:Number ):void {
			_speedCountLabel.text = val.toString();
			_speedCountLabel.draw();
			_speedLabel.x = _speedCountLabel.x + _speedCountLabel.width;
		}
		
		public function drawMessage( message:String ):void {
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
