package com.funrun.game.model {
	
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	public class GeosModel {
		public const EMPTY_GEO:String = "EMPTY_GEO";
		public const LEDGE_GEO:String = "LEDGE_GEO";
		public const WALL_GEO:String = "WALL_GEO";
		public const BEAM_GEO:String = "BEAM_GEO";
		private var _geos:Object;
		
		public function GeosModel() {
			_geos = {};
			_geos[ EMPTY_GEO ] = new PlaneGeometry( 1, 1 );
			_geos[ LEDGE_GEO ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 5 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
			_geos[ WALL_GEO ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 2 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
			_geos[ BEAM_GEO ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
		}
		
		public function getGeo( id:String ):PrimitiveBase {
			return _geos[ id ];
		}
	}
}
