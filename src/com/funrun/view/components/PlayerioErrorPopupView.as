package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.utils.Center;
	import com.funrun.controller.signals.vo.PlayerioErrorVo;
	
	import playerio.PlayerIOError;
	
	public class PlayerioErrorPopupView extends Popup {
		
		private var _error:PlayerIOError;
		private var _messageLabel:AbstractLabel;
		
		public function PlayerioErrorPopupView( vo:PlayerioErrorVo ) {
			super( null, 0, 0, 600, 500 );
			_error = vo.error;
		}
		
		public function init():void {
			_messageLabel = new AbstractLabel( this );
			_messageLabel.text = "There was a server error. " + _error.name + " " + _error.errorID + " " + _error.type + " " + _error.message + " " + _error.getStackTrace();
		}
		
		override public function destroy():void {
			super.destroy();
			_messageLabel.destroy();
			_messageLabel = null;
			_error = null;
		}
		
		override public function draw():void {
			super.draw();
			_messageLabel.draw();
			Center.both( _messageLabel, this );
			_messageLabel.y -= 100;
		}
	}
}
