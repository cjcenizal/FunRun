package com.funrun.game.model.data
{
	import com.funrun.game.model.IObstacleProvider;
	import com.funrun.game.model.constants.FaceTypes;
	import com.funrun.game.model.parsers.BlockParser;
	
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
		
		public function CollisionsCollection() {
			_collisions = [];
		}
		
		public function addCollisions( collisions:Array ):void {
			if ( collisions ) {
				_collisions = _collisions.concat( collisions );
			}
		}
		
		public function get numCollisions():int {
			return _collisions.length;
		}
		
		public function getAt( index:int ):FaceCollision {
			return _collisions[ index ];
		}
		
		public function reduce( minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			
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
					obsX + obstacle.minX, obsX + obstacle.maxX,
					obsY + obstacle.minY, obsY + obstacle.maxY,
					obsZ + obstacle.minZ, obsZ + obstacle.maxZ,
					minX, maxX, minY, maxY, minZ, maxZ
				) ) {
					// Get the faces we collide with for each box.
					var box:BoundingBoxData;
					var numBlocks:int = obstacle.numBoundingBoxes;
					for ( var j:int = 0; j < numBlocks; j++ ) {
						box = obstacle.getBoundingBoxAt( j );
						// TO-DO: We can optimize further here by checking
						// for each face that accepts collisions,
						// and only test against those.
						addCollisions( getFaceCollisions(
							box.block,
							obsX + box.minX, obsX + box.maxX,
							obsY + box.minY, obsY + box.maxY,
							obsZ + box.minZ, obsZ + box.maxZ,
							minX, maxX, minY, maxY, minZ, maxZ
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
			block:BlockParser,
			aMinX:Number, aMaxX:Number, aMinY:Number, aMaxY:Number, aMinZ:Number, aMaxZ:Number,
			bMinX:Number, bMaxX:Number, bMinY:Number, bMaxY:Number, bMinZ:Number, bMaxZ:Number
		):Array {
			var arr:Array = [];
			if ( doCollide( aMinX, aMaxX, aMinY, aMaxY, aMinZ, aMaxZ, bMinX, bMaxX, bMinY, bMaxY, bMinZ, bMaxZ ) ) {
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
			aMinX:Number, aMaxX:Number, aMinY:Number, aMaxY:Number, aMinZ:Number, aMaxZ:Number,
			bMinX:Number, bMaxX:Number, bMinY:Number, bMaxY:Number, bMinZ:Number, bMaxZ:Number
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