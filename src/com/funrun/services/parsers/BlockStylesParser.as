package com.funrun.services.parsers {
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.model.vo.BlockTypeVo;
	
	public class BlockStylesParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function BlockStylesParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):BlockStyleVo {
			return new BlockStyleParser().parse( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}
