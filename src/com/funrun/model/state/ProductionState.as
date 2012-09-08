package com.funrun.model.state {
	
	public class ProductionState {
		
		public var isProduction:Boolean;
		public var _showStats:Boolean = false;
		
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
	}
}
