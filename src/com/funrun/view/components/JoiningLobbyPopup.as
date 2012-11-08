package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.utils.Center;
	
	public class JoiningLobbyPopup extends Popup {
		
		private var _messageLabel:AbstractLabel;
		
		public function JoiningLobbyPopup() {
			super( null, 0, 0, 600, 500 );
		}
		
		public function init():void {
			_messageLabel = new AbstractLabel( this );
			_messageLabel.text = "Joining lobby..."
		}
		
		override public function destroy():void {
			super.destroy();
			_messageLabel.destroy();
			_messageLabel = null;
		}
		
		override public function draw():void {
			super.draw();
			_messageLabel.draw();
			Center.both( _messageLabel, this );
			_messageLabel.y -= 100;
		}
	}
}