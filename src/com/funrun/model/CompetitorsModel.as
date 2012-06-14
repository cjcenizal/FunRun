package com.funrun.model {

	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Actor;

	public class CompetitorsModel extends Actor {
		
		private var _competitors:Object;
		private var _competitorsArray:Array;
		private var _liveCompetitors:Object;
		private var _numLiveCompetitors:int;

		public function CompetitorsModel() {
			super();
			reset();
		}
		
		public function add( competitor:CompetitorVO ):void {
			_competitors[ competitor.id ] = competitor;
			_competitorsArray.push( competitor );
			_liveCompetitors[ competitor.id ] = competitor;
			if ( !competitor.isDead ) {
				_numLiveCompetitors++;
			}
		}
		
		public function remove( id:int ):void {
			var competitor:CompetitorVO = getWithId( id );
			if ( !competitor.isDead ) {
				_numLiveCompetitors--;
			}
			delete _liveCompetitors[ id ];
			delete _competitors[ id ];
			for ( var i:int = 0; i < _competitorsArray.length; i++ ) {
				if ( getAt( i ) == competitor ) {
					_competitorsArray.splice( i, 1 );
					return;
				}
			}
		}
		
		public function kill( id:int ):void {
			var competitor:CompetitorVO = getWithId( id );
			if ( !competitor.isDead ) {
				competitor.isDead = true;
				_numLiveCompetitors--;
				delete _liveCompetitors[ id ];
			}
		}
		
		public function reset():void {
			_competitors = {};
			_competitorsArray = [];
			_liveCompetitors = {};
			_numLiveCompetitors = 0;
		}
		
		public function getWithId( id:int ):CompetitorVO {
			return _competitors[ id ];
		}
		
		public function getAt( i:int ):CompetitorVO {
			return _competitorsArray[ i ];
		}
		
		public function get numCompetitors():int {
			return _competitorsArray.length;
		}
		
		public function get numLiveCompetitors():int {
			return _numLiveCompetitors;
		}
	}
}
