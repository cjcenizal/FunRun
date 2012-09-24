package com.funrun.model.state {
	
	public class ProductionState {
		
		public var isProduction:Boolean;
		private var _showStats:Boolean = false;
		private var _isExploration:Boolean = false;
		
		public function ProductionState( isProduction:Boolean ) {
			this.isProduction = isProduction;
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
