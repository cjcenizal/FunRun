package com.funrun.model {

	import com.funrun.model.vo.DelayedCommandVo;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;

	public class DelayedCommandsModel extends Actor {
		
		private var _delayedCommands:Array;
		
		public function DelayedCommandsModel() {
			super();
			_delayedCommands = [];
		}
		
		public function add( signal:Signal, delayMs:int, arg:* = null ):void {
			var callback:Function = function( command:DelayedCommandVo ):void {
				if ( arg ) {
					var type:Class = Object( arg ).constructor;
					signal.dispatch.call( null, arg as type );
				} else {
					signal.dispatch.call( null );
				}
				remove( command );
			}
			_delayedCommands.push( new DelayedCommandVo( delayMs, callback ) );
		}
		
		public function remove( command:DelayedCommandVo ):void {
			command.destroy();
			for ( var i:int = 0; i < _delayedCommands.length; i++ ) {
				if ( _delayedCommands[ i ] == command ) {
					_delayedCommands.splice( i, 1 );
					return;
				}
			}
		}
		
		public function removeAll():void {
			while ( _delayedCommands.length > 0 ) {
				remove( _delayedCommands[ 0 ] as DelayedCommandVo );
			}
		}
	}
}
