package com.funrun.services.parsers {
	
	import com.funrun.model.constants.Block;
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.geom.Vector3D;
	
	public class BlockStyleParser {
		
		private const FILES:String = "files";
		private const OFFSETS:String = "offsets";
		
		public function BlockStyleParser() {
		}
		
		public function parse( data:Object ):BlockStyleVo {
			var id:String = new IdParser( data ).id;
			var files:Object = data[ FILES ] || {};
			var offsets:Object = data[ OFFSETS ] || {};
			return new BlockStyleVo( id, files, offsets );
		}
	}
}