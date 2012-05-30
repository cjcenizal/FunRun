package com.funrun.model {

	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Actor;

	public class CompetitorsModel extends Actor {

		private var _competitors:Object;

		public function CompetitorsModel() {
			_competitors = {};
		}
		
		public function add( competitor:CompetitorVO ):void {
			_competitors[ competitor.id ] = competitor;
		}
		
		public function getWithId( id:int ):CompetitorVO {
			return _competitors[ id ];
		}
	}
}
