package com.funrun.model {

	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Actor;

	public class CompetitorsModel extends Actor {
		
		private var _competitors:Object;
		private var _competitorsArray:Array;
		private var _liveCompetitorsArray:Array;

		public function CompetitorsModel() {
			super();
			reset();
		}
		
		public function add( competitor:CompetitorVO ):void {
			_competitors[ competitor.id ] = competitor;
			_competitorsArray.push( competitor );
			if ( !competitor.isDead ) {
				competitor.liveIndex = _liveCompetitorsArray.length;
				_liveCompetitorsArray.push( competitor );
			}
		}
		
		public function remove( id:int ):void {
			var competitor:CompetitorVO = getWithId( id );
			for ( var i:int = 0; i < _liveCompetitorsArray.length; i++ ) {
				if ( _liveCompetitorsArray[ i ] == competitor ) {
					_liveCompetitorsArray.splice( i, 1 );
					i--;
				}
				if ( i >= 0 ) {
					( _liveCompetitorsArray[ i ] as CompetitorVO ).liveIndex = i;
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
			var competitor:CompetitorVO = getWithId( id );
			if ( competitor ) {
				competitor.kill();
				for ( var i:int = 0; i < _liveCompetitorsArray.length; i++ ) {
					if ( _liveCompetitorsArray[ i ] == competitor ) {
						_liveCompetitorsArray.splice( i, 1 );
						i--;
					}
					if ( i >= 0 ) {
						( _liveCompetitorsArray[ i ] as CompetitorVO ).liveIndex = i;
					}
				}
			}
		}
		
		public function reset():void {
			_competitors = {};
			_competitorsArray = [];
			_liveCompetitorsArray = [];
		}
		
		public function getWithId( id:int ):CompetitorVO {
			return _competitors[ id ];
		}
		
		public function getAt( i:int ):CompetitorVO {
			return _competitorsArray[ i ];
		}
		
		public function getLiveCompetitorAt( i:int ):CompetitorVO {
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
