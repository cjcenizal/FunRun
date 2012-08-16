package com.funrun.model.vo {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.cenizal.physics.collisions.ICollidable;

	public class SegmentVO extends CollidableVO implements ICollidable {
		
		public static var useBoundsMesh:Boolean = false;
		
		private var _mesh:Mesh;
		private var _boundsMesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;

		public function SegmentVO( mesh:Mesh, boundsMesh:Mesh, boundingBoxes:Array, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			super( 0, 0, 0, minX, minY, minZ, maxX, maxY, maxZ );
			_mesh = mesh;
			_boundsMesh = boundsMesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
		}
		
		override public function add( collidable:ICollidable ):ICollidable {
			return new SegmentVO(
				_mesh, _boundsMesh, _boundingBoxes,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
		
		public function clone():SegmentVO {
			return new SegmentVO( _mesh.clone() as Mesh, ( _boundsMesh ) ? _boundsMesh.clone() as Mesh : null, _boundingBoxes, _minX, _minY, _minZ, _maxX, _maxY, _maxZ );
		}
		
		/**
		 * Get this obstacle's mesh.
		 * @return The original.
		 */
		public function get mesh():Mesh {
			return _mesh;
		}
		
		public function get boundsMesh():Mesh {
			return _boundsMesh;
		}
		
		public function get numBoundingBoxes():int {
			return _numBoundingBoxes;
		}
		
		public function getBoundingBoxes():Array {
			return _boundingBoxes;
		}
		
		public function getBoundingBoxAt( index:int ):BoundingBoxVO {
			return _boundingBoxes[ index ];
		}
		
		override public function set x( val:Number ):void {
			super.x = val;
			_mesh.x = val;
			if ( _boundsMesh ) {
				_boundsMesh.x = val;
			}
		}
		
		override public function set y( val:Number ):void {
			super.y = val;
			_mesh.y = val;
			if ( _boundsMesh ) {
				_boundsMesh.y = val;
			}
		}
		
		override public function set z( val:Number ):void {
			super.z = val;
			_mesh.z = val;
			if ( _boundsMesh ) {
				_boundsMesh.z = val;
			}
		}
		
		public function get width():Number {
			return _maxX - _minX;
		}

		public function get height():Number {
			return _maxY - _minY;
		}
		
		public function get depth():Number {
			return _maxZ - _minZ;
		}
	}
}
