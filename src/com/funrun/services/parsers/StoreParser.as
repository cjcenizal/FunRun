package com.funrun.services.parsers {

	import com.funrun.model.vo.BlockVo;
	
	public class StoreParser extends AbstractParser {
		
		private const LIST:String = "list";
		
		public function StoreParser( data:Object ) {
			super( data );
		}
		
		public function getWithId( id:String ):String {
			return data[ LIST ][ id ];
		}
	}
}
