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
			var collidee:ICollidable;
			var count:int = collidees.length;
			for ( var i:int = 0; i < count; i++ ) {
				collidee = collidees[ i ];
				if ( collideeOffset ) {
					collidee = collidee.add( collideeOffset );
				}
				if ( doTheyIntersect( collider, collidee ) ) {
					var volume:Number = getIntersectionVolume( collider, collidee );
					if ( volume > 0 ) {
						collisions.push( { "index": i, "volume" : volume } );
					}
				}
			}
			collisions.sortOn( "volume", Array.NUMERIC | Array.DESCENDING );
			for ( var i:int = 0; i < collisions.length; i++ ) {
				collisions[ i ] = collisions[ i ][ "index" ];
			}
			return collisions;
		}
		
		/**
		 * Get the faces we've collided with.
		 * The face indicates the face of the collidee,
		 * not the collider. Faces are sorted in order
		 * of increasingly deeper penetration.
		 * 
		 * @return An array of faces indicating collisions.
		 */
		public static function getCollidingFaces( collider:ICollidable, collidee:ICollidable ):FaceCollisionsVO {
			// Get faces.
			var faces:Array = [];
			var amounts:Array = [];
			// Use intersection distances to order faces by shallowness.
			var xPenetration:Number = getFaceIntersection( collider, collidee, Axis.X );
			var yPenetration:Number = getFaceIntersection( collider, collidee, Axis.Y );
			var zPenetration:Number = getFaceIntersection( collider, collidee, Axis.Z );
			
			if ( Math.abs( xPenetration ) > 0) {
				faces.push( {
					"face" : ( xPenetration > 0 ) ? Face.LEFT : Face.RIGHT,
					"amount" : Math.abs( xPenetration )
				} );
			}
			if ( Math.abs( yPenetration ) > 0 ) {
				faces.push( {
					"face" : ( yPenetration > 0 ) ? Face.TOP : Face.BOTTOM,
					"amount" : Math.abs( yPenetration )
				} );
			}
			if ( Math.abs( zPenetration ) > 0 ) {
				faces.push( {
					"face" : ( zPenetration > 0 ) ? Face.FRONT : Face.BACK,
					"amount" : Math.abs( zPenetration )
				} );
			}
			faces.sortOn( "amount", Array.NUMERIC );
			for ( var i:int = 0; i < faces.length; i++ ) {
				amounts.push( faces[ i ][ "amount" ] );
				faces[ i ] = faces[ i ][ "face" ];
			}
			return new FaceCollisionsVO( faces, amounts );
		}
		
		/**
		 * Get the distance and sign by which two objects intersect.
		 * This is the value relative to the collidee, not the collider.
		 * A larger magnitude value (e.g. Math.abs([returned value]))
		 * indicates the absolute intersection distance. This can be
		 * used to determine if certain intersections are deeper or
		 * shallow than others.
		 * 
		 * A positive returned value indicates that the collidee is
		 * positioned lower/less than the collider, while negative
		 * indicates the opposite.
		 * 
		 * Be sure to check if objects are even intersecting before
		 * getting intersection distance.
		 * 
		 * @return Boolean.
		 */
		private static function getFaceIntersection( collider:ICollidable, collidee:ICollidable, axis:String ):Number {
			var aMin:Number = ( axis == Axis.X ) ? collider.worldMinX : ( axis == Axis.Y ) ? collider.worldMinY : collider.worldMinZ;
			var aMax:Number = ( axis == Axis.X ) ? collider.worldMaxX : ( axis == Axis.Y ) ? collider.worldMaxY : collider.worldMaxZ;
			var bMin:Number = ( axis == Axis.X ) ? collidee.worldMinX : ( axis == Axis.Y ) ? collidee.worldMinY : collidee.worldMinZ;
			var bMax:Number = ( axis == Axis.X ) ? collidee.worldMaxX : ( axis == Axis.Y ) ? collidee.worldMaxY : collidee.worldMaxZ;
			var smallMin:Number, smallMax:Number, bigMin:Number, bigMax:Number;
			if ( ( aMax - aMin ) <= ( bMax - bMin ) ) {
				smallMin = aMin;
				smallMax = aMax;
				bigMin = bMin;
				bigMax = bMax;
			} else {
				smallMin = bMin;
				smallMax = bMax;
				bigMin = aMin;
				bigMax = aMax;
			}
			// Small is contained inside big.
			if ( bigMin <= smallMin && bigMax >= smallMax ) {
				if ( bigMax - smallMax > smallMin - bigMin ) {
					// It's near the greater end.
					return bigMax - smallMax;
				} else {
					// It's near the lesser end.
					return bigMin - smallMin;
				}
			}
			// Small intersects the lesser end of big.
			if ( smallMin < bigMin && smallMax > bigMin ) {
				return smallMax - bigMin;
			}
			// Small intersects the greater end of big.
			if ( smallMin < bigMax && smallMax > bigMax ) {
				return smallMin - bigMax;
			}
			// They intersect exactly on one another.
			return 0;
		}
		
		private static function getPenetration( collider:ICollidable, collidee:ICollidable, axis:String ):Number {
			var aMin:Number = ( axis == Axis.X ) ? collider.worldMinX : ( axis == Axis.Y ) ? collider.worldMinY : collider.worldMinZ;
			var aMax:Number = ( axis == Axis.X ) ? collider.worldMaxX : ( axis == Axis.Y ) ? collider.worldMaxY : collider.worldMaxZ;
			var bMin:Number = ( axis == Axis.X ) ? collidee.worldMinX : ( axis == Axis.Y ) ? collidee.worldMinY : collidee.worldMinZ;
			var bMax:Number = ( axis == Axis.X ) ? collidee.worldMaxX : ( axis == Axis.Y ) ? collidee.worldMaxY : collidee.worldMaxZ;
			var smallMin:Number, smallMax:Number, bigMin:Number, bigMax:Number;
			if ( ( aMax - aMin ) <= ( bMax - bMin ) ) {
				smallMin = aMin;
				smallMax = aMax;
				bigMin = bMin;
				bigMax = bMax;
			} else {
				smallMin = bMin;
				smallMax = bMax;
				bigMin = aMin;
				bigMax = aMax;
			}
			// They don't intersect.
			if ( smallMax < bigMin || smallMin > bigMax ) {
				return 0;
			}
			// It's contained inside.
			if ( smallMin < bigMin && smallMax > bigMax ) {
				return smallMax - smallMin;
			}
			// It intersects the small end.
			if ( smallMin < bigMin && smallMax > bigMin ) {
				return smallMax - bigMin;
			}
			// It intersects the big end.
			if ( smallMin < bigMax && smallMax > bigMax ) {
				return bigMax - smallMin;
			}
			// They intersect exactly on one another.
			return smallMax - smallMin;
		}
		
		public static function doTheyIntersect( collider:ICollidable, collidee:ICollidable ):Boolean {
			if ( collider.worldMinX >= collidee.worldMaxX || collidee.worldMinX >= collider.worldMaxX ) {
				return false;
			}
			if ( collider.worldMinY >= collidee.worldMaxY || collidee.worldMinY >= collider.worldMaxY ) {
				return false;
			}
			if ( collider.worldMinZ >= collidee.worldMaxZ || collidee.worldMinZ >= collider.worldMaxZ ) {
				return false;
			}
			return true;
		}
		
		private static function getIntersectionVolume( collider:ICollidable, collidee:ICollidable ):Number {		
			if ( doTheyIntersect( collider, collidee ) ) {
				var xPenetration:Number = getPenetration( collider, collidee, Axis.X );
				var yPenetration:Number = getPenetration( collider, collidee, Axis.Y );
				var zPenetration:Number = getPenetration( collider, collidee, Axis.Z );
				return xPenetration * yPenetration * zPenetration;
			}
			return 0;
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
		
	}
}