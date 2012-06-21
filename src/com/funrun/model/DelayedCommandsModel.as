package com.funrun.model {

	import com.funrun.model.vo.DelayedCommandVO;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;

	public class DelayedCommandsModel extends Actor {
		
		private var _delayedCommands:Array;
		
		public function DelayedCommandsModel() {
			super();
			_delayedCommands = [];
		}
		
		public function add( signal:Signal, delayMs:int, args... ):void {
			var callback:Function = function( command:DelayedCommandVO ) {
				signal.dispatch.apply( null, args );
				remove( command );
			}
		}
		
		public function remove( command:DelayedCommandVO ):void {
			command.destroy();
			for ( var i:int = 0; i < _delayedCommands.length; i++ ) {
				if ( _delayedCommands[ i ] == command ) {
					_delayedCommands.splice( i, 1 );
					return;
				}
			}
		}
	}
}
