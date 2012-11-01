package com.funrun.services.parsers {
	
	import com.funrun.model.constants.Block;
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.geom.Vector3D;
	
	public class BlockStyleParser {
		
		private const BLOCKS:String = "blocks";
		
		public function BlockStyleParser() {
		}
		
		public function parse( data:Object ):BlockStyleVo {
			var id:String = new IdParser( data ).id;
			var meshes:Object = data[ BLOCKS ] || {};
			return new BlockStyleVo( id, meshes );
		}
	}
}