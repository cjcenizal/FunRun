package com.funrun.model.collision
{
	import com.funrun.model.IObstacleProvider;
	import com.funrun.model.constants.FaceTypes;
	import com.funrun.model.vo.BlockVO;
	
	/**
	 * CollisionData provides information
	 * on which faces of an obstacle a player
	 * has collided with.
	 * 
	 * It gives information on the faces
	 * 
	 * @author CJ Cenizal
	 */
	public class CollisionsCollection {
		
		private static const BOX:String = "box";
		private static const FACE:String = "face";
		
		private var _collisions:Array;
		private var _numCollisions:int = 0;
		
		public function CollisionsCollection() {
			_collisions = [];
		}
		
		public function addCollisions( collisions:Array ):void {
			if ( collisions ) {
				_collisions = _collisions.concat( collisions );
				_numCollisions = _collisions.length;
			}
		}
		
		public function get numCollisions():int {
			return _numCollisions;
		}
		
		public function getAt( index:int ):FaceCollision {
			return _collisions[ index ];
		}
		
		/**
		 * Detect collisions against stored faces, and remove any that don't collide.
		 * 
		 * @param minX Min x of player bounds.
		 * @param minY Min y of player bounds.
		 * @param minZ Min z of player bounds.
		 * @param maxX Max x of player bounds.
		 * @param maxY Max y of player bounds.
		 * @param maxZ Max z of player bounds.
		 */
		public function recollideAgainst( minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ):void {
			var keptCollisions:Array = [];
			var face:FaceCollision;
			for ( var i:int = 0; i < _numCollisions; i++ ) {
				face = _collisions[ i ] as FaceCollision;
				if ( doCollide( minX, minY, minZ, maxX, maxY, maxZ,
					face.minX, face.minY, face.minZ, face.maxX, face.maxY, face.maxZ ) ) {
					keptCollisions.push( face );
				}
			}
			_collisions = keptCollisions;
		}
		
		public function collectCollisions( obstacles:IObstacleProvider,
									 minX:Number, minY:Number, minZ:Number,
									 maxX:Number, maxY:Number, maxZ:Number ):void {
			var numObstacles:int = obstacles.numObstacles;
			var obstacle:ObstacleData;
			for ( var i:int = 0; i < numObstacles; i++ ) {
				obstacle = obstacles.getObstacleAt( i );
				var obsX:Number = obstacle.x;
				var obsY:Number = obstacle.y;
				var obsZ:Number = obstacle.z;
				// Optimize by checking against obstacle bounds first.
				if ( doCollide(
					obsX + obstacle.minX, obsY + obstacle.minY, obsZ + obstacle.minZ,
					obsX + obstacle.maxX, obsY + obstacle.maxY, obsZ + obstacle.maxZ,
					minX, minY, minZ, maxX, maxY, maxZ
				) ) {
					// Get the faces we collide with for each box.
					var box:BoundingBoxData;
					var numBlocks:int = obstacle.numBoundingBoxes;
					for ( var j:int = 0; j < numBlocks; j++ ) {
						box = obstacle.getBoundingBoxAt( j );
						addCollisions( getFaceCollisions(
							box.block,
							obsX + box.minX, obsY + box.minY, obsZ + box.minZ,
							obsX + box.maxX, obsY + box.maxY, obsZ + box.maxZ,
							minX, minY, minZ, maxX, maxY, maxZ
						) );
					}
				}
			}
		}
		
		/**
		 * Get the faces we've collided with.
		 * Face bounds get collapsed to be 2-dimensional.
		 * Pass in the obstacle's arguments first:
		 * a is the obstacle, and b is the player.
		 * 
		 * @return An array of FaceCollision objects.
		 */
		private static function getFaceCollisions(
			block:BlockVO,
			aMinX:Number, aMinY:Number, aMinZ:Number, aMaxX:Number, aMaxY:Number, aMaxZ:Number,
			bMinX:Number, bMinY:Number, bMinZ:Number, bMaxX:Number, bMaxY:Number, bMaxZ:Number
		):Array {
			var arr:Array = [];
			if ( doCollide( aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ,
				bMinX, bMinY, bMinZ, bMaxX, bMaxY, bMaxZ ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX && block.doesFaceCollide( FaceTypes.RIGHT ) ) {
					// A is left of B, but A's max overlaps B's min: right.
					arr.push( new FaceCollision(
						FaceTypes.RIGHT,
						block.getEventAtFace( FaceTypes.RIGHT ),
						aMaxX, aMinY, aMinZ,
						aMaxX, aMaxY, aMaxZ
					) );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX && block.doesFaceCollide( FaceTypes.LEFT ) ) {
					// B is left of A, but B's max overlaps A's min: left.
					arr.push( new FaceCollision(
						FaceTypes.LEFT,
						block.getEventAtFace( FaceTypes.LEFT ),
						aMinX, aMinY, aMinZ,
						aMinX, aMaxY, aMaxZ
					) );
				}
				if ( aMinY <= bMinY && aMaxY >= bMinY && block.doesFaceCollide( FaceTypes.TOP ) ) {
					// A is below B, but A's max overlaps B's min: top.
					arr.push( new FaceCollision(
						FaceTypes.TOP,
						block.getEventAtFace( FaceTypes.TOP ),
						aMinX, aMaxY, aMinZ,
						aMaxX, aMaxY, aMaxZ
					) );
				}
				if ( bMinY <= aMinY && bMaxY >= aMinY && block.doesFaceCollide( FaceTypes.BOTTOM ) ) {
					// B is below A, but B's max overlaps A's min: bottom.
					arr.push( new FaceCollision(
						FaceTypes.BOTTOM,
						block.getEventAtFace( FaceTypes.BOTTOM ),
						aMinX, aMinY, aMinZ,
						aMaxX, aMinY, aMaxZ
					) );
				}
				if ( aMinZ <= bMinZ && aMaxZ >= bMinZ && block.doesFaceCollide( FaceTypes.BACK ) ) {
					// A is in front of B, but A's max overlaps B's min: aft.
					arr.push( new FaceCollision(
						FaceTypes.BACK,
						block.getEventAtFace( FaceTypes.BACK ),
						aMinX, aMinY, aMaxZ,
						aMaxX, aMaxY, aMaxZ
					) );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ && block.doesFaceCollide( FaceTypes.FRONT ) ) {
					// B is in front of A, but B's max overlaps A's min: front.
					arr.push( new FaceCollision(
						FaceTypes.FRONT,
						block.getEventAtFace( FaceTypes.FRONT ),
						aMinX, aMinY, aMinZ,
						aMaxX, aMaxY, aMinZ
					) );
				}
				return arr;
			}
			return null;
		}
		
		private static function doCollide(
			aMinX:Number, aMinY:Number, aMinZ:Number, aMaxX:Number, aMaxY:Number, aMaxZ:Number,
			bMinX:Number, bMinY:Number, bMinZ:Number, bMaxX:Number, bMaxY:Number, bMaxZ:Number
		):Boolean {
			if ( aMinX > bMaxX || bMinX > aMaxX ) {
				return false;
			}
			if ( aMinY > bMaxY || bMinY > aMaxY ) {
				return false;
			}
			if ( aMinZ > bMaxZ || bMinZ > aMaxZ ) {
				return false;
			}
			return true;
		}
	}
}