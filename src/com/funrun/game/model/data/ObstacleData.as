package com.funrun.game.model.data {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.constants.BlockTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.parsers.BlockParser;
	import com.funrun.game.model.parsers.ObstacleParser;

	public class ObstacleData {

		private var _mesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;
		private var _z:Number = 0;

		public function ObstacleData( mesh:Mesh, boundingBoxes:Array ) {
			_mesh = mesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
		}
		
		public function clone():ObstacleData {
			return new ObstacleData( _mesh.clone() as Mesh, _boundingBoxes );
		}
		
		/**
		 * Get this obstacle's mesh.
		 * @return The original.
		 */
		public function get mesh():Mesh {
			return _mesh;
		}
		
		public function get numBoundingBoxes():int {
			return _numBoundingBoxes;
		}
		
		public function getBoundingBoxAt( index:int ):BoundingBoxData {
			return _boundingBoxes[ index ];
		}
		
		public function set z( val:Number ):void {
			_mesh.z = _z = val;
		}
		
		public function get z():Number {
			return _z;
		}
		
		public function get bounds():BoundingVolumeBase {
			return _mesh.bounds;
		}
		
		public static function make( blocksModel:BlocksModel, materialsModel:MaterialsModel, obstacle:ObstacleParser, flip:Boolean = false ):ObstacleData {
			var boundingBoxes:Array = [];
			var geo:PrimitiveBase, mesh:Mesh, pitMap:Object, minX:int, minZ:int, maxX:int, maxZ:int;
			var material:MaterialBase = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL ); // TO-DO: Customize this
			var merge:Merge = new Merge( true );
			var obstacleMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material ); // TO-DO: Customize this geo
			var boundingBoxes:Array = [];
			pitMap = {};
			minX = 0;
			minZ = 0;
			maxX = TrackConstants.TRACK_WIDTH_BLOCKS - 1;
			maxZ = 0;
			// Add obstacle geometry.
			for ( var j:int = 0; j < obstacle.numBlocks; j++ ) {
				var data:BlockData = obstacle.getBlockAt( j );
				var geoData:BlockParser = blocksModel.getBlock( data.id );
				geo = geoData.geo;
				mesh = new Mesh( geo, material );
				var posX:int = ( flip ) ? ( TrackConstants.TRACK_WIDTH_BLOCKS - data.x - 1 ) : data.x;
				mesh.x = posX * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
				mesh.y = data.y * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
				mesh.z = data.z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
				merge.apply( obstacleMesh, mesh );
				
				// Add a bounding box so we can collide with the obstacle.
				var boundingBox:BoundingBoxData = new BoundingBoxData(
					blocksModel.getBlock( data.id ),
					mesh.x - TrackConstants.BLOCK_SIZE_HALF,
					mesh.y - TrackConstants.BLOCK_SIZE_HALF,
					mesh.z - TrackConstants.BLOCK_SIZE_HALF,
					mesh.x + TrackConstants.BLOCK_SIZE_HALF,
					mesh.y + TrackConstants.BLOCK_SIZE_HALF,
					mesh.z + TrackConstants.BLOCK_SIZE_HALF
				);
				
				// Store pit location.
				if ( !pitMap[ posX ] ) {
					pitMap[ posX ] = {};
				}
				if ( data.y < 0 ) {
					// We only want to store positives, not negative.
					pitMap[ posX ][ data.z ] = true;
				}
				// Update bounds of obstacle.
				minX = Math.min( posX, minX );
				minZ = Math.min( data.z, minZ );
				maxX = Math.max( posX, maxX );
				maxZ = Math.max( data.z, maxZ );
			}
			// Fill in floor geometry wherever no pits exist.
			var floorType:String = BlockTypes.FLOOR;
			geo = blocksModel.getBlock( floorType ).geo; // TO-DO: Customize this geo
			material = materialsModel.getMaterial( MaterialsModel.GROUND_MATERIAL ); // TO-DO: Customize this
			for ( var x:int = minX; x <= maxX; x++ ) {
				for ( var z:int = minZ; z <= maxZ; z++ ) {
					if ( !pitMap[ x ] || !pitMap[ x ][ z ] ) {
						mesh = new Mesh( geo, material );
						mesh.x = x * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
						mesh.y = TrackConstants.BLOCK_SIZE * -.5;
						mesh.z = z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
						merge.apply( obstacleMesh, mesh );
						
						// Add a bounding box so we can collide with the floor.
						var boundingBox:BoundingBoxData = new BoundingBoxData(
							blocksModel.getBlock( floorType ),
							mesh.x - TrackConstants.BLOCK_SIZE_HALF,
							mesh.y - TrackConstants.BLOCK_SIZE_HALF,
							mesh.z - TrackConstants.BLOCK_SIZE_HALF,
							mesh.x + TrackConstants.BLOCK_SIZE_HALF,
							mesh.y + TrackConstants.BLOCK_SIZE_HALF,
							mesh.z + TrackConstants.BLOCK_SIZE_HALF
						);
					}
				}
			}
			return new ObstacleData( obstacleMesh, boundingBoxes );
		}
	}
}
