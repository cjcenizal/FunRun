package com.funrun.model {

	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Actor;

	public class CompetitorsModel extends Actor {
		
		private var _competitors:Object;
		private var _competitorsArray:Array;
		private var _liveCompetitorsArray:Array;

		public function CompetitorsModel() {
			super();
			reset();
		}
		
		public function add( competitor:CompetitorVo ):void {
			_competitors[ competitor.id ] = competitor;
			_competitorsArray.push( competitor );
			if ( !competitor.isDead ) {
				competitor.liveIndex = _liveCompetitorsArray.length;
				_liveCompetitorsArray.push( competitor );
			}
		}
		
		public function remove( id:int ):void {
			var competitor:CompetitorVo = getWithId( id );
			for ( var i:int = 0; i < _liveCompetitorsArray.length; i++ ) {
				if ( _liveCompetitorsArray[ i ] == competitor ) {
					_liveCompetitorsArray.splice( i, 1 );
					i--;
				}
				if ( i >= 0 ) {
					( _liveCompetitorsArray[ i ] as CompetitorVo ).liveIndex = i;
				}
			}
			delete _competitors[ id ];
			for ( var i:int = 0; i < _competitorsArray.length; i++ ) {
				if ( getAt( i ) == competitor ) {
					_competitorsArray.splice( i, 1 );
					break;
				}
			}
		}
		
		public function kill( id:int ):void {
			var competitor:CompetitorVo = getWithId( id );
			if ( competitor ) {
				competitor.kill();
				for ( var i:int = 0; i < _liveCompetitorsArray.length; i++ ) {
					if ( _liveCompetitorsArray[ i ] == competitor ) {
						_liveCompetitorsArray.splice( i, 1 );
						i--;
					}
					if ( i >= 0 ) {
						( _liveCompetitorsArray[ i ] as CompetitorVo ).liveIndex = i;
					}
				}
			}
		}
		
		public function reset():void {
			_competitors = {};
			_competitorsArray = [];
			_liveCompetitorsArray = [];
		}
		
		public function getWithId( id:int ):CompetitorVo {
			return _competitors[ id ];
		}
		
		public function getAt( i:int ):CompetitorVo {
			return _competitorsArray[ i ];
		}
		
		public function getLiveCompetitorAt( i:int ):CompetitorVo {
			return _liveCompetitorsArray[ i ];
		}
		
		public function get numCompetitors():int {
			return _competitorsArray.length;
		}
		
		public function get numLiveCompetitors():int {
			return _liveCompetitorsArray.length;
		}
	}
}
