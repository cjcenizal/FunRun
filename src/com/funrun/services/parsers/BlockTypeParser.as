package com.funrun.services.parsers {
	
	import com.funrun.model.vo.BlockTypeVo;
	import com.funrun.model.constants.Block;
	
	import flash.geom.Vector3D;

	public class BlockTypeParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		private const BOUNDS:String = "bounds";
		
		public function BlockTypeParser() {
		}
		
		public function parse( data:Object ):BlockTypeVo {
			var id:String = new IdParser( data ).id;
			//var filename:String = new FilenameParser( data ).filename;
			var faces:Object = data[ FACES ] || {};
			var bounds:Array = data[ BOUNDS ];
			var boundsMin:Vector3D = new Vector3D( bounds[ 0 ], bounds[ 1 ], bounds[ 2 ] );
			boundsMin.scaleBy( Block.HALF_SIZE );
			var boundsMax:Vector3D = new Vector3D( bounds[ 3 ], bounds[ 4 ], bounds[ 5 ] );
			boundsMax.scaleBy( Block.HALF_SIZE );
			return new BlockTypeVo( id, faces, boundsMin, boundsMax );
		}
	}
}