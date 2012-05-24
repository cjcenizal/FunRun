package com.funrun.services.parsers {
	
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
