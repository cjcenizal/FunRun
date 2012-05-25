package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.utils.Center;
	import com.funrun.model.vo.ResultsPopupVO;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class ResultsPopup extends Popup {
		
		private var _vo:ResultsPopupVO;
		private var _messageLabel:AbstractLabel;
		private var _button:DummyButton;
		public var onClickMainMenuSignal:Signal;
		
		public function ResultsPopup( vo:ResultsPopupVO ) {
			super( null, 0, 0, 600, 500 );
			_vo = vo;
		}
		
		public function init():void {
			_messageLabel = new AbstractLabel( this );
			_messageLabel.text = _vo.distanceMessage;
			_button = new DummyButton( this, 0, 0, onClick, "Main menu", 0xFFAA00 );
			onClickMainMenuSignal = new Signal();
		}
		
		override public function destroy():void {
			super.destroy();
			_messageLabel.destroy();
			_messageLabel = null;
			_button.destroy();
			_button = null;
			onClickMainMenuSignal.removeAll();
			onClickMainMenuSignal = null;
			_vo = null;
		}
		
		override public function draw():void {
			super.draw();
			_messageLabel.draw();
			Center.both( _messageLabel, this );
			_messageLabel.y -= 100;
			_button.draw();
			Center.horizontal( _button, this );
			_button.y = _messageLabel.y + _messageLabel.height + 20;
		}
		
		private function onClick( e:MouseEvent ):void {
			onClickMainMenuSignal.dispatch();
		}
	}
}
