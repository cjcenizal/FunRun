package com.funrun.game.model.parsers {
	
	public class BlocksParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function BlocksParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):BlockParser {
			return new BlockParser( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
