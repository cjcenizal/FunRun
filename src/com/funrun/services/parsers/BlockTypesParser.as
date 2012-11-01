package com.funrun.services.parsers {
	import com.funrun.model.vo.BlockTypeVo;
	
	public class BlockTypesParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function BlockTypesParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):BlockTypeVo {
			return new BlockTypeParser().parse( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
