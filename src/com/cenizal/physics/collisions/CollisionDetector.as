package com.cenizal.physics.collisions
{
	
	/**
	 * CollisionData provides information
	 * on which faces of an obstacle a player
	 * has collided with.
	 * 
	 * Reference: http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
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
			var minX:Number = collider.worldMinX;
			var minY:Number = collider.worldMinY;
			var minZ:Number = collider.worldMinZ;
			var maxX:Number = collider.worldMaxX;
			var maxY:Number = collider.worldMaxY;
			var maxZ:Number = collider.worldMaxZ;
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
					collisions.push( { "index": i, "volume" : volume } );
				}
			}
			collisions.sortOn( "volume", Array.NUMERIC | Array.DESCENDING );
			for ( var i:int = 0; i < collisions.length; i++ ) {
				collisions[ i ] = collisions[ i ][ "index" ];
			}
			return collisions;
		}
		
		private static function output( collider:ICollidable, collidee:ICollidable ):void {
			var aMinX:Number = collider.worldMinX;
			var aMinY:Number = collider.worldMinY;
			var aMinZ:Number = collider.worldMinZ;
			var aMaxX:Number = collider.worldMaxX;
			var aMaxY:Number = collider.worldMaxY;
			var aMaxZ:Number = collider.worldMaxZ;
			var bMinX:Number = collidee.worldMinX;
			var bMinY:Number = collidee.worldMinY;
			var bMinZ:Number = collidee.worldMinZ;
			var bMaxX:Number = collidee.worldMaxX;
			var bMaxY:Number = collidee.worldMaxY;
			var bMaxZ:Number = collidee.worldMaxZ;
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
		public static function getCollidingFaces( collider:ICollidable, collidee:ICollidable ):FaceCollisionsVO {
			var aMinX:Number = collider.worldMinX;
			var aMinY:Number = collider.worldMinY;
			var aMinZ:Number = collider.worldMinZ;
			var aMaxX:Number = collider.worldMaxX;
			var aMaxY:Number = collider.worldMaxY;
			var aMaxZ:Number = collider.worldMaxZ;
			
			var bMinX:Number = collidee.worldMinX;
			var bMinY:Number = collidee.worldMinY;
			var bMinZ:Number = collidee.worldMinZ;
			var bMaxX:Number = collidee.worldMaxX;
			var bMaxY:Number = collidee.worldMaxY;
			var bMaxZ:Number = collidee.worldMaxZ;
			
			var faces:Array = [];
			if ( doTheyIntersect( collider, collidee ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX ) {
					// A is left of B, but A's max overlaps B's min: right.
					faces.push( Face.LEFT );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX ) {
					// B is left of A, but B's max overlaps A's min: left.
					faces.push( Face.RIGHT );
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
					faces.push( Face.FRONT );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ ) {
					// B is in front of A, but B's max overlaps A's min: front.
					faces.push( Face.BACK );
				}
			}
			// Intersect the two collidables, and get the width, height, and depth of the resulting cube.
			var xPenetration:Number = getIntersectionDistance( aMinX, aMaxX, bMinX, bMaxX );
			var yPenetration:Number = getIntersectionDistance( aMinY, aMaxY, bMinY, bMaxY );
			var zPenetration:Number = getIntersectionDistance( aMinZ, aMaxZ, bMinZ, bMaxZ );
			return new FaceCollisionsVO( faces, xPenetration, yPenetration, zPenetration );
		}
		
		/**
		 * Check whether two objects collide on a specific face.
		 * The face indicates the face of the collidee,
		 * not the collider.
		 * 
		 * @return Boolean.
		 */
		public static function collidesWithFace( collider:ICollidable, collidee:ICollidable, face:String, checkIntersection:Boolean = true ):Boolean {
			if ( checkIntersection && doTheyIntersect( collider, collidee ) ) {
				var min:Number, max:Number, test:Number;
				switch ( face ) {
					case Face.LEFT:
						min = collider.worldMinX;
						max = collider.worldMaxX;
						test = collidee.worldMinX;
						break;
					case Face.RIGHT:
						min = collider.worldMinX;
						max = collider.worldMaxX;
						test = collidee.worldMaxX;
						break;
					case Face.BOTTOM:
						min = collider.worldMinY;
						max = collider.worldMaxY;
						test = collidee.worldMinY;
						break;
					case Face.TOP:
						min = collider.worldMinY;
						max = collider.worldMaxY;
						test = collidee.worldMaxY;
						break;
					case Face.FRONT:
						min = collider.worldMinZ;
						max = collider.worldMaxZ;
						test = collidee.worldMinZ;
						break;
					case Face.BACK:
						min = collider.worldMinZ;
						max = collider.worldMaxZ;
						test = collidee.worldMaxZ;
						break;
				}
				return ( min <= test && max >= test );
			}
			return false;
		}
		
		public static function doTheyIntersect( collider:ICollidable, collidee:ICollidable ):Boolean {
			var aMinX:Number = collider.worldMinX;
			var aMinY:Number = collider.worldMinY;
			var aMinZ:Number = collider.worldMinZ;
			var aMaxX:Number = collider.worldMaxX;
			var aMaxY:Number = collider.worldMaxY;
			var aMaxZ:Number = collider.worldMaxZ;
			
			var bMinX:Number = collidee.worldMinX;
			var bMinY:Number = collidee.worldMinY;
			var bMinZ:Number = collidee.worldMinZ;
			var bMaxX:Number = collidee.worldMaxX;
			var bMaxY:Number = collidee.worldMaxY;
			var bMaxZ:Number = collidee.worldMaxZ;
			
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
			var aMinX:Number = collider.worldMinX;
			var aMinY:Number = collider.worldMinY;
			var aMinZ:Number = collider.worldMinZ;
			var aMaxX:Number = collider.worldMaxX;
			var aMaxY:Number = collider.worldMaxY;
			var aMaxZ:Number = collider.worldMaxZ;
			
			var bMinX:Number = collidee.worldMinX;
			var bMinY:Number = collidee.worldMinY;
			var bMinZ:Number = collidee.worldMinZ;
			var bMaxX:Number = collidee.worldMaxX;
			var bMaxY:Number = collidee.worldMaxY;
			var bMaxZ:Number = collidee.worldMaxZ;
			
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