package com.funrun.services.parsers {
	import com.funrun.model.vo.BlockVo;
	
	public class BlocksListParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function BlocksListParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):BlockVo {
			return new BlockParser().parse( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
