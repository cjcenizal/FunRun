package com.funrun.model {
	import org.robotlegs.mvcs.Actor;
	
	public class GameModel extends Actor {
		
		public var isProduction:Boolean;
		public var isOnline:Boolean;
		public var showBounds:Boolean;
		public var isMultiplayer:Boolean;
		public var usePoints:Boolean = true;
		public var killAiTicksInterval:Number = 200;
		
		private var _showStats:Boolean = false;
		private var _isExploration:Boolean = false;
		
		public function GameModel( isProduction:Boolean, isOnline:Boolean, showBounds:Boolean = false ) {
			super();
			this.isProduction = isProduction;
			this.isOnline = isOnline;
			this.showBounds = showBounds;
		}
		
		public function set showStats( val:Boolean ):void {
			if ( !this.isProduction ) {
				_showStats = val;
			} else {
				_showStats = false;
			}
		}
		
		public function get showStats():Boolean {
			return _showStats;
		}
		
		public function set isExploration( val:Boolean ):void {
			if ( !this.isProduction ) {
				_isExploration = val;
			} else {
				_isExploration = false;
			}
		}
		
		public function get isExploration():Boolean {
			return _isExploration;
		}
		
	}
}
