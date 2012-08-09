package com.cenizal.physics.collisions
{
	
	/**
	 * CollisionData provides information
	 * on which faces of an obstacle a player
	 * has collided with.
	 * 
	 * It gives information on the faces
	 * 
	 * @author CJ Cenizal
	 */
	public class CollisionDetector {
		
		private static const BOX:String = "box";
		private static const FACE:String = "face";
		
		/**
		 * Detect collisions between collidables.
		 * 
		 * @return An array of indices indicating collisions.
		 */
		public static function getCollidingIndices( collider:ICollidable, collidees:Array, collideeOffset:ICollidable = null ):Array {
			var collisions:Array = [];
			var count:int = collidees.length;
			var collidee:ICollidable;
			var minX:Number = collider.x + collider.minX;
			var minY:Number = collider.y + collider.minY;
			var minZ:Number = collider.z + collider.minZ;
			var maxX:Number = collider.x + collider.maxX;
			var maxY:Number = collider.y + collider.maxY;
			var maxZ:Number = collider.z + collider.maxZ;
			var x:Number, y:Number, z:Number;
			
			var fail:Boolean = true;
			
			for ( var i:int = 0; i < count; i++ ) {
				collidee = collidees[ i ];
				if ( collideeOffset ) {
					collidee = collidee.add( collideeOffset );
				}
				x = collidee.x;
				y = collidee.y;
				z = collidee.z;
				// Optimize by checking against obstacle bounds first.
				var volume:Number = getIntersectionVolume( collider, collidee );
				if ( volume > 0 ) {
					collisions.push( i );
				}
			}
			return collisions;
		}
		
		private static function output( collider:ICollidable, collidee:ICollidable ):void {
			var aMinX:Number = collider.x + collider.minX;
			var aMinY:Number = collider.y + collider.minY;
			var aMinZ:Number = collider.z + collider.minZ;
			var aMaxX:Number = collider.x + collider.maxX;
			var aMaxY:Number = collider.y + collider.maxY;
			var aMaxZ:Number = collider.z + collider.maxZ;
			
			var bMinX:Number = collidee.x + collidee.minX;
			var bMinY:Number = collidee.y + collidee.minY;
			var bMinZ:Number = collidee.z + collidee.minZ;
			var bMaxX:Number = collidee.x + collidee.maxX;
			var bMaxY:Number = collidee.y + collidee.maxY;
			var bMaxZ:Number = collidee.z + collidee.maxZ;
			
			trace("a: min(",aMinX, aMinY, aMinZ, "), max(",aMaxX, aMaxY, aMaxZ,")");
			trace("b: min(", bMinX, bMinY, bMinZ, "), max(",bMaxX, bMaxY, bMaxZ,")");
		}
		
		/**
		 * Get the faces we've collided with.
		 * Pass in the obstacle's arguments first:
		 * a is the obstacle, and b is the player.
		 * The face indicates the face of the collidee,
		 * not the collider.
		 * 
		 * @return An array of faces indicating collisions.
		 */
		public static function getCollidingFaces( collider:ICollidable, collidee:ICollidable, forced:Boolean = false ):FaceCollisionsVO {
			
			var aMinX:Number = collider.x + collider.minX;
			var aMinY:Number = collider.y + collider.minY;
			var aMinZ:Number = collider.z + collider.minZ;
			var aMaxX:Number = collider.x + collider.maxX;
			var aMaxY:Number = collider.y + collider.maxY;
			var aMaxZ:Number = collider.z + collider.maxZ;
			
			var bMinX:Number = collidee.x + collidee.minX;
			var bMinY:Number = collidee.y + collidee.minY;
			var bMinZ:Number = collidee.z + collidee.minZ;
			var bMaxX:Number = collidee.x + collidee.maxX;
			var bMaxY:Number = collidee.y + collidee.maxY;
			var bMaxZ:Number = collidee.z + collidee.maxZ;
			
			var faces:Array = [];
			if ( forced || doTheyIntersect( collider, collidee ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX ) {
					// A is left of B, but A's max overlaps B's min: right.
					faces.push( Face.RIGHT );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX ) {
					// B is left of A, but B's max overlaps A's min: left.
					faces.push( Face.LEFT );
				}
				if ( aMinY <= bMinY && aMaxY >= bMinY ) {
					// A is below B, but A's max overlaps B's min: top.
					faces.push( Face.BOTTOM );
				}
				if ( bMinY <= aMinY && bMaxY >= aMinY ) {
					// B is below A, but B's max overlaps A's min: bottom.
					faces.push( Face.TOP );
				}
				if ( aMinZ <= bMinZ && aMaxZ >= bMinZ ) {
					// A is in front of B, but A's max overlaps B's min: aft.
					faces.push( Face.BACK );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ ) {
					// B is in front of A, but B's max overlaps A's min: front.
					faces.push( Face.FRONT );
				}
				// Intersect the two collidables, and get the width, height, and depth of the resulting cube.
				var xPenetration:Number = getIntersectionDistance( aMinX, aMaxX, bMinX, bMaxX );
				var yPenetration:Number = getIntersectionDistance( aMinY, aMaxY, bMinY, bMaxY );
				var zPenetration:Number = getIntersectionDistance( aMinZ, aMaxZ, bMinZ, bMaxZ );
				return new FaceCollisionsVO( faces, xPenetration, yPenetration, zPenetration );
			}
			return null;
		}
		
		private static function doTheyIntersect( collider:ICollidable, collidee:ICollidable ):Boolean {
			var aMinX:Number = collider.x + collider.minX;
			var aMinY:Number = collider.y + collider.minY;
			var aMinZ:Number = collider.z + collider.minZ;
			var aMaxX:Number = collider.x + collider.maxX;
			var aMaxY:Number = collider.y + collider.maxY;
			var aMaxZ:Number = collider.z + collider.maxZ;
			
			var bMinX:Number = collidee.x + collidee.minX;
			var bMinY:Number = collidee.y + collidee.minY;
			var bMinZ:Number = collidee.z + collidee.minZ;
			var bMaxX:Number = collidee.x + collidee.maxX;
			var bMaxY:Number = collidee.y + collidee.maxY;
			var bMaxZ:Number = collidee.z + collidee.maxZ;
			
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
		
		private static function getIntersectionVolume( collider:ICollidable, collidee:ICollidable ):Number {
			var aMinX:Number = collider.x + collider.minX;
			var aMinY:Number = collider.y + collider.minY;
			var aMinZ:Number = collider.z + collider.minZ;
			var aMaxX:Number = collider.x + collider.maxX;
			var aMaxY:Number = collider.y + collider.maxY;
			var aMaxZ:Number = collider.z + collider.maxZ;
			
			var bMinX:Number = collidee.x + collidee.minX;
			var bMinY:Number = collidee.y + collidee.minY;
			var bMinZ:Number = collidee.z + collidee.minZ;
			var bMaxX:Number = collidee.x + collidee.maxX;
			var bMaxY:Number = collidee.y + collidee.maxY;
			var bMaxZ:Number = collidee.z + collidee.maxZ;
			
			if ( aMinX > bMaxX || bMinX > aMaxX ) {
				return 0;
			}
			if ( aMinY > bMaxY || bMinY > aMaxY ) {
				return 0;
			}
			if ( aMinZ > bMaxZ || bMinZ > aMaxZ ) {
				return 0;
			}
			
			var xPenetration:Number = Math.max( 0, getIntersectionDistance( aMinX, aMaxX, bMinX, bMaxX ) );
			var yPenetration:Number = Math.max( 0, getIntersectionDistance( aMinY, aMaxY, bMinY, bMaxY ) );
			var zPenetration:Number = Math.max( 0, getIntersectionDistance( aMinZ, aMaxZ, bMinZ, bMaxZ ) );
			
			return xPenetration * yPenetration * zPenetration;
		}
		
		private static function getIntersectionDistance( aMin:Number, aMax:Number, bMin:Number, bMax:Number ):Number {
			return ( aMax < bMax ) ? ( aMax - bMin ) : ( bMax - aMin );
		}
		
	}
}