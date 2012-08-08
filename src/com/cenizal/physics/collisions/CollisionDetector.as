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
		public static function getCollidingIndices( collider:ICollidable, collidees:Array ):Array {
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
			for ( var i:int = 0; i < count; i++ ) {
				collidee = collidees[ i ];
				x = collidee.x;
				y = collidee.y;
				z = collidee.z;
				// Optimize by checking against obstacle bounds first.
				var theyDoIntersect:Boolean = doTheyIntersect(
					x + collidee.minX, y + collidee.minY, z + collidee.minZ,
					x + collidee.maxX, y + collidee.maxY, z + collidee.maxZ,
					minX, minY, minZ, maxX, maxY, maxZ );
				if ( theyDoIntersect ) {
					collisions.push( i );
				}
			}
			return collisions;
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
			
			//trace("a:",aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ);
			//trace("b:", bMinX, bMinY, bMinZ, bMaxX, bMaxY, bMaxZ);
			
			var arr:Array = [];
			if ( doTheyIntersect( aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ,
				bMinX, bMinY, bMinZ, bMaxX, bMaxY, bMaxZ ) ) {
				if ( aMinX <= bMinX && aMaxX >= bMinX ) {
					// A is left of B, but A's max overlaps B's min: right.
					arr.push( RIGHT );
				}
				if ( bMinX <= aMinX && bMaxX >= aMinX ) {
					// B is left of A, but B's max overlaps A's min: left.
					arr.push( LEFT );
				}
				if ( aMinY <= bMinY && aMaxY >= bMinY ) {
					// A is below B, but A's max overlaps B's min: top.
					arr.push( BOTTOM );
				}
				if ( bMinY <= aMinY && bMaxY >= aMinY ) {
					// B is below A, but B's max overlaps A's min: bottom.
					arr.push( TOP );
				}
				if ( aMinZ <= bMinZ && aMaxZ >= bMinZ ) {
					// A is in front of B, but A's max overlaps B's min: aft.
					arr.push( BACK );
				}
				if ( bMinZ <= aMinZ && bMaxZ >= aMinZ ) {
					// B is in front of A, but B's max overlaps A's min: front.
					arr.push( FRONT );
				}
				return arr;
			}
			return null;
		}
		
		private static function doTheyIntersect(
			aMinX:Number, aMinY:Number, aMinZ:Number, aMaxX:Number, aMaxY:Number, aMaxZ:Number,
			bMinX:Number, bMinY:Number, bMinZ:Number, bMaxX:Number, bMaxY:Number, bMaxZ:Number
		):Boolean {
			//trace("a:",aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ);
			//trace("b:", bMinX, bMinY, bMinZ, bMaxX, bMaxY, bMaxZ);
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