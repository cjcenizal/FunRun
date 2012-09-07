package com.funrun.services.parsers {
	
	import com.funrun.model.vo.BlockVo;
	import com.funrun.model.constants.Block;
	
	import flash.geom.Vector3D;

	public class BlockParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		private const BOUNDS:String = "bounds";
		
		public function BlockParser() {
		}
		
		public function parse( data:Object ):BlockVo {
			var id:String = new IdParser( data ).id;
			var filename:String = new FilenameParser( data ).filename;
			var faces:Object = data[ FACES ] || {};
			var bounds:Array = data[ BOUNDS ];
			var boundsMin:Vector3D = new Vector3D( bounds[ 0 ], bounds[ 1 ], bounds[ 2 ] );
			boundsMin.scaleBy( Block.HALF_SIZE );
			var boundsMax:Vector3D = new Vector3D( bounds[ 3 ], bounds[ 4 ], bounds[ 5 ] );
			boundsMax.scaleBy( Block.HALF_SIZE );
			return new BlockVo( id, filename, faces, boundsMin, boundsMax );
		}
	}
}