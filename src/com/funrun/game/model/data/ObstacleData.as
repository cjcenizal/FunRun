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
		private var _minX:Number;
		private var _minY:Number;
		private var _minZ:Number;
		private var _maxX:Number;
		private var _maxY:Number;
		private var _maxZ:Number;

		public function ObstacleData( mesh:Mesh, boundingBoxes:Array, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			_mesh = mesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
			_minX = minX;
			_minY = minY;
			_minZ = minZ;
			_maxX = maxX;
			_maxY = maxY;
			_maxZ = maxZ;
		}
		
		public function clone():ObstacleData {
			return new ObstacleData( _mesh.clone() as Mesh, _boundingBoxes, _minX, _minY, _minZ, _maxX, _maxY, _maxZ );
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

		public function get x():Number {
			return _mesh.x;
		}
		
		public function get y():Number {
			return _mesh.y;
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
		
		public function get minX():Number {
			return _minX;
		}
		
		public function get minY():Number {
			return _minY;
		}
		
		public function get minZ():Number {
			return _minZ;
		}
		
		public function get maxX():Number {
			return _maxX;
		}
		
		public function get maxY():Number {
			return _maxY;
		}
		
		public function get maxZ():Number {
			return _maxZ;
		}
		
		public static function make( blocksModel:BlocksModel, materialsModel:MaterialsModel, parser:ObstacleParser, flip:Boolean = false ):ObstacleData {
			
			// TO-DO:
			// We need to be able to specify here that some blocks on top of pit edges
			// need to be walkable and not obstacle.
			
			var boundingBoxes:Array = [];
			var geo:PrimitiveBase, mesh:Mesh, pitMap:Object, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number;
			
			// TO-DO: Customize this with a material specific to the block.
			var material:MaterialBase = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
			
			var merge:Merge = new Merge( true );
			
			// TO-DO: Customize this geo to be specific to the block.
			var obstacleMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material );
			
			var boundingBoxes:Array = [];
			pitMap = {};
			minX = 0;
			minY = 0;
			minZ = 0;
			maxX = TrackConstants.TRACK_WIDTH_BLOCKS - 1;
			maxY = 0;
			maxZ = 0;
			// Add obstacle geometry.
			for ( var j:int = 0; j < parser.numBlocks; j++ ) {
				var data:BlockData = parser.getBlockAt( j );
				var geoData:BlockParser = blocksModel.getBlock( data.id );
				geo = geoData.geo;
				mesh = new Mesh( geo, material );
				var posX:int = ( flip ) ? ( TrackConstants.TRACK_WIDTH_BLOCKS - data.x - 1 ) : data.x;
				mesh.x = posX * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
				mesh.y = data.y * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
				mesh.z = data.z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
				merge.apply( obstacleMesh, mesh );
				
				// Add a bounding box so we can collide with the obstacle.
				boundingBoxes.push( new BoundingBoxData(
					blocksModel.getBlock( data.id ),
					mesh.x, mesh.y, mesh.z,
					mesh.x - TrackConstants.BLOCK_SIZE_HALF,
					mesh.y - TrackConstants.BLOCK_SIZE_HALF,
					mesh.z - TrackConstants.BLOCK_SIZE_HALF,
					mesh.x + TrackConstants.BLOCK_SIZE_HALF,
					mesh.y + TrackConstants.BLOCK_SIZE_HALF,
					mesh.z + TrackConstants.BLOCK_SIZE_HALF
				) );
				
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
			
			// TO-DO: Customize this geo to be specific to the block.
			geo = blocksModel.getBlock( floorType ).geo;
			
			// TO-DO: Customize this to be specific to the block.
			material = materialsModel.getMaterial( MaterialsModel.GROUND_MATERIAL );
			
			// Fill in gaps with floors.
			for ( var x:int = minX; x <= maxX; x++ ) {
				for ( var z:int = minZ; z <= maxZ; z++ ) {
					if ( !pitMap[ x ] || !pitMap[ x ][ z ] ) {
						mesh = new Mesh( geo, material );
						mesh.x = x * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
						mesh.y = TrackConstants.BLOCK_SIZE * -.5;
						mesh.z = z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
						merge.apply( obstacleMesh, mesh );
						
						// Add a bounding box so we can collide with the floor.
						boundingBoxes.push( new BoundingBoxData(
							blocksModel.getBlock( floorType ),
							mesh.x, mesh.z, mesh.z,
							mesh.x - TrackConstants.BLOCK_SIZE_HALF,
							mesh.y - TrackConstants.BLOCK_SIZE_HALF,
							mesh.z - TrackConstants.BLOCK_SIZE_HALF,
							mesh.x + TrackConstants.BLOCK_SIZE_HALF,
							mesh.y + TrackConstants.BLOCK_SIZE_HALF,
							mesh.z + TrackConstants.BLOCK_SIZE_HALF
						) );
					}
				}
			}
			
			// Store bounds. Adjust values to be absolute instead of relative.
			minX = TrackConstants.TRACK_WIDTH * -.5;
			maxX = TrackConstants.TRACK_WIDTH * .5;
			minY *= TrackConstants.BLOCK_SIZE;
			maxY *= TrackConstants.BLOCK_SIZE;
			minZ *= TrackConstants.BLOCK_SIZE;
			maxZ *= TrackConstants.BLOCK_SIZE;
			
			return new ObstacleData( obstacleMesh, boundingBoxes, minX, minY, minZ, maxX, maxY, maxZ );
		}
	}
}
