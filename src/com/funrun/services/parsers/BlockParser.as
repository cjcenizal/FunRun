package com.funrun.services.parsers {
	
	import com.funrun.model.vo.BlockVo;

	public class BlockParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		
		public function BlockParser() {
		}
		
		public function parse( data:Object ):BlockVo {
			var id:String = new IdParser( data ).id;
			var filename:String = new FilenameParser( data ).filename;
			var faces:Object = data[ FACES ] || {};
			return new BlockVo( id, filename, faces );
		}
	}
}