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
		
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const FRONT:String = "front";
		public static const BACK:String = "back"; // a is for ass... or aft.
		public static const ALL:String = "all";
		
		private static const BOX:String = "box";
		private static const FACE:String = "face";
		
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
		/*public function recollideAgainst( minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ):void {
		var keptCollisions:Array = [];
		var face:Collision;
		for ( var i:int = 0; i < _numCollisions; i++ ) {
		face = _collisions[ i ] as Collision;
		if ( doCollide( minX, minY, minZ, maxX, maxY, maxZ,
		face.minX, face.minY, face.minZ, face.maxX, face.maxY, face.maxZ ) ) {
		keptCollisions.push( face );
		}
		}
		_collisions = keptCollisions;
		}*/
		
		
		/**
		 * Detect collisions between collidables.
		 * 
		 * @return An array of indices indicating collisions.
		 */
		public static function getCollidingIndices( collider:ICollidable, collidees:Array, limits:Object = null, debug:Boolean = false ):Array {
			limits = limits || {};
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
				x = collidee.x;
				y = collidee.y;
				z = collidee.z;
				// Optimize by checking against obstacle bounds first.
				var theyDoIntersect:Boolean = doTheyIntersect( collider, collidee, limits,debug );
				if ( debug ) {
					if ( theyDoIntersect ) fail = false;
					trace(theyDoIntersect);
					output(collider, collidee);
				}
				if ( theyDoIntersect ) {
					collisions.push( i );
				}
			}
			if ( debug && fail ) trace(" ====================================================================================================================================");
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
		public static function getCollidingFaces( collider:ICollidable, collidee:ICollidable ):Array {
			
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
			if ( doTheyIntersect( collider, collidee ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX ) {
					// A is left of B, but A's max overlaps B's min: right.
					faces.push( RIGHT );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX ) {
					// B is left of A, but B's max overlaps A's min: left.
					faces.push( LEFT );
				}
				if ( aMinY <= bMinY && aMaxY >= bMinY ) {
					// A is below B, but A's max overlaps B's min: top.
					faces.push( BOTTOM );
				}
				if ( bMinY <= aMinY && bMaxY >= aMinY ) {
					// B is below A, but B's max overlaps A's min: bottom.
					faces.push( TOP );
				}
				if ( aMinZ <= bMinZ && aMaxZ >= bMinZ ) {
					// A is in front of B, but A's max overlaps B's min: aft.
					faces.push( BACK );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ ) {
					// B is in front of A, but B's max overlaps A's min: front.
					faces.push( FRONT );
				}
			}
			return faces;
		}
		
		private static function doTheyIntersect( collider:ICollidable, collidee:ICollidable, limits:Object = null, debug:Boolean = false ):Boolean {
			limits = limits || {};
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
			
			if ( !limits.X && ( aMinX > bMaxX || bMinX > aMaxX ) ) {
				if ( debug ) trace("    fail x", aMinX, aMaxX, bMinX, bMaxX );
				return false;
			}
			if ( !limits.Y && ( aMinY > bMaxY || bMinY > aMaxY ) ) {
				if ( debug ) trace("    fail y", aMinY, aMaxY, bMinY, bMaxY );
				return false;
			}
			if ( !limits.Z && ( aMinZ > bMaxZ || bMinZ > aMaxZ ) ) {
				if ( debug ) trace("    fail z", aMinZ, aMaxZ, bMinZ, bMaxZ );
				return false;
			}
			return true;
		}
	}
}