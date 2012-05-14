package com.funrun.game.model.data
{
	import com.funrun.game.model.constants.FaceTypes;
	
	/**
	 * CollisionData provides information
	 * on which faces of an obstacle a player
	 * has collided with.
	 * 
	 * It gives information on the faces
	 * 
	 * @author CJ Cenizal
	 */
	public class CollisionData
	{
		private static const BOX:String = "box";
		private static const FACE:String = "face";
		
		private var _collisions:Array;
		
		public function CollisionData()
		{
			_collisions = [];
		}
		
		public function addCollision( box:BoundingBoxData, face:String ):void {
			var obj:Object = {};
			obj[ BOX ] = box;
			obj[ FACE ] = face;
			_collisions.push( obj );
		}
		
		public function get numCollisions():int {
			return _collisions.length;
		}
		
		public function getBoxAt( index:int ):BoundingBoxData {
			return _collisions[ index ][ BOX ];
		}
		
		public function getFaceAt( index:int ):String {
			return _collisions[ index ][ FACE ];
		}
		
		public static function make( obstacle:ObstacleData, minX:Number, maxX:Number, minY:Number, maxY:Number, minZ:Number, maxZ:Number ):CollisionData {
			/*if ( doCollide(
				obstacle.x + obstacle.minX, obstacle.x + obstacle.maxX, obstacle.y + obstacle.minY, obstacle.y + obstacle.maxY, obstacle.z + obstacle.minZ, obstacle.z + obstacle.maxZ,
				minX, maxX, minY, maxY, minZ, maxZ
			) ) {*/
				// Get the faces we collide with for each box.
				var collisions:CollisionData = new CollisionData();
				var box:BoundingBoxData;
				var len:int = obstacle.numBoundingBoxes;
				var obsX:Number = obstacle.x;
				var obsY:Number = obstacle.y;
				var obsZ:Number = obstacle.z;
				for ( var i:int = 0; i < len; i++ ) {
					box = obstacle.getBoundingBoxAt( i );
					var faces:Array = getFaceCollisionsWithObstacle(
						obsX + box.minX, obsX + box.maxX,
						obsY + box.minY, obsY + box.maxY,
						obsZ + box.minZ, obsZ + box.maxZ,
						minX, maxX, minY, maxY, minZ, maxZ
					);
					if ( faces ) {
						for ( var j:int = 0; j < faces.length; j++ ) {
							collisions.addCollision( box, faces[ j ] );
						}
					}
				}
				return collisions;
			//}
			return null;
		}
		
		/**
		 * Get the faces we've collided with.
		 * Pass in the obstacle's arguments first.
		 * 
		 * @return An array of FaceTypes constants.
		 */
		private static function getFaceCollisionsWithObstacle(
			aMinX:Number, aMaxX:Number, aMinY:Number, aMaxY:Number, aMinZ:Number, aMaxZ:Number,
			bMinX:Number, bMaxX:Number, bMinY:Number, bMaxY:Number, bMinZ:Number, bMaxZ:Number
		):Array {
			var arr:Array = [];
			if ( doCollide( aMinX, aMaxX, aMinY, aMaxY, aMinZ, aMaxZ, bMinX, bMaxX, bMinY, bMaxY, bMinZ, bMaxZ ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX ) {
					// A is left of B, but A's max overlaps B's min: right.
					arr.push( FaceTypes.RIGHT );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX ) {
					// B is left of A, but B's max overlaps A's min: left.
					arr.push( FaceTypes.LEFT );
				}
				if ( aMinY <= bMinY && aMaxY >= bMinY ) {
					// A is below B, but A's max overlaps B's min: bottom.
					arr.push( FaceTypes.TOP );
				}
				if ( bMinY <= aMinY && bMaxY >= aMinY ) {
					// B is below A, but B's max overlaps A's min: top.
					arr.push( FaceTypes.BOTTOM );
				}
				if ( aMinZ <= bMinZ && aMaxZ >= bMinZ ) {
					// A is in front of B, but A's max overlaps B's min: aft.
					arr.push( FaceTypes.AFT );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ ) {
					// B is in front of A, but B's max overlaps A's min: front.
					arr.push( FaceTypes.FRONT );
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