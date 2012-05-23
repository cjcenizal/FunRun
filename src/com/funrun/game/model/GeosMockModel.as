package com.funrun.game.model {
	
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.game.model.constants.BlockTypes;
	
	import org.robotlegs.mvcs.Actor;
	import com.funrun.game.model.constants.BlockTypes;
	import com.funrun.game.model.constants.TrackConstants;
	
	public class GeosMockModel extends Actor implements IGeosModel {
		
		private var _geos:Object;
		
		public function GeosMockModel() {
			_geos = {};
			_geos[ BlockTypes.EMPTY ] = new PlaneGeometry( 1, 1 );
			_geos[ BlockTypes.BLOCK ] = new CubeGeometry( 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE );
			_geos[ BlockTypes.FLOOR ] = new CubeGeometry( 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE );
			_geos[ BlockTypes.CEILING ] = new CubeGeometry( 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE, 1 * TrackConstants.BLOCK_SIZE );
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
