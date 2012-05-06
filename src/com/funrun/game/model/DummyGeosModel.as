package com.funrun.game.model {
	
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	public class DummyGeosModel implements IGeosModel {
		
		public const EMPTY:String = "EMPTY";
		public const BLOCK:String = "BLOCK";
		private var _geos:Object;
		
		public function DummyGeosModel() {
			_geos = {};
			_geos[ EMPTY ] = new PlaneGeometry( 1, 1 );
			_geos[ BLOCK ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
		}
		
		public function getGeo( id:String ):PrimitiveBase {
			// Throw error here if undefined.
			return _geos[ id ];
		}
	}
}
