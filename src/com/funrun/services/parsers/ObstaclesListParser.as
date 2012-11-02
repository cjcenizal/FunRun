package com.funrun.services.parsers {
	
	
	public class ObstaclesListParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function ObstaclesListParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):String {
			return data[ LIST ][ index ];
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
