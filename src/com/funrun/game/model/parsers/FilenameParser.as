package com.funrun.game.model.parsers {
	
	public class FilenameParser extends AbstractParser {
		
		private const FILENAME:String = "filename";
		
		public function FilenameParser( data:Object ) {
			super( data );
		}
		
		public function get filename():String {
			return data[ FILENAME ];
		}
	}
}
