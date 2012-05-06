package com.funrun.game.model.parsers {
	
	public class IdParser extends AbstractParser {
		
		private const ID:String = "id";
		
		public function IdParser( data:Object ) {
			super( data );
		}
		
		public function get id():String {
			return data[ ID ];
		}
	}
}
