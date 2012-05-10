package com.funrun.game.model {
	
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.game.model.BlockTypes;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DummyGeosModel extends Actor implements IGeosModel {
		
		private var _geos:Object;
		
		public function DummyGeosModel() {
			_geos = {};
			_geos[ BlockTypes.EMPTY ] = new PlaneGeometry( 1, 1 );
			_geos[ BlockTypes.BLOCK ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
			_geos[ BlockTypes.FLOOR ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
		}
		
		public function getGeo( id:String ):PrimitiveBase {
			// Throw error here if undefined.
			if ( !_geos[ id ] ) {
				trace( this, "Geo does not exist for BlockType " + id );
			}
			return _geos[ id ];
		}
	}
}
