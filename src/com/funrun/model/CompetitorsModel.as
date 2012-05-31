package com.funrun.model {

	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Actor;

	public class CompetitorsModel extends Actor {

		private var _competitors:Object;
		private var _competitorsArray:Array;

		public function CompetitorsModel() {
			_competitors = {};
			_competitorsArray = [];
		}
		
		public function add( competitor:CompetitorVO ):void {
			_competitors[ competitor.id ] = competitor;
			_competitorsArray.push( competitor );
		}
		
		public function remove( id:int ):void {
			var comp:CompetitorVO = getWithId( id );
			delete _competitors[ id ];
			for ( var i:int = 0; i < _competitorsArray.length; i++ ) {
				if ( getAt( i ) == comp ) {
					_competitorsArray.splice( i, 1 );
					return;
				}
			}
		}
		
		public function reset():void {
			_competitors = {};
			_competitorsArray = [];
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
	}
}
