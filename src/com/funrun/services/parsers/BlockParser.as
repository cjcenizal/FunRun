package com.funrun.services.parsers {
	
	import com.funrun.model.vo.BlockVO;

	public class BlockParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		
		public function BlockParser() {
		}
		
		public function parse( data:Object ):BlockVO {
			var id:String = new IdParser( data ).id;
			var filename:String = new FilenameParser( data ).filename;
			var faces:Object = data[ FACES ] || {};
			return new BlockVO( id, filename, faces );
		}
	}
}