package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;

	public class MessagesList extends AbstractComponent {
		
		private var _messages:Array;
		
		public function MessagesList( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			_messages = [];
		}
		
		public function clear():void {
			// TO-DO: Clear all messages.
		}
		
		public function add( message:String ):void {
			var label:AbstractLabel = new AbstractLabel( this, 0, 0, message, 10 );
			for ( var i:int = 0; i < _messages.length; i++ ) {
				( _messages[ i ] as AbstractLabel ).y -= 14;
			}
			_messages.push( label );
			TweenLite.to( label, 1, {
				alpha : 0,
				delay: 5,
				onComplete: function() {
					for ( var i:int = 0; i < _messages.length; i++ ) {
						if ( _messages[ i ] == label ) {
							label.destroy();
							_messages.splice( i, 1 );
							return;
						}
					}
				}
			} );
		}
	}
}
