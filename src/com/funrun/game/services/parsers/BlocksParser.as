package com.funrun.game.services.parsers {
	import com.funrun.game.model.vo.BlockVO;
	
	public class BlocksParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function BlocksParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):BlockVO {
			return new BlockParser().parse( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
