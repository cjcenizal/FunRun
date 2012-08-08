package com.funrun.model.vo {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.cenizal.physics.collisions.ICollidable;

	public class SegmentVO implements ICollidable{
		
		public static var useBoundsMesh:Boolean = false;
		
		private var _id:String;
		private var _mesh:Mesh;
		private var _boundsMesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;
		private var _z:Number = 0;
		private var _minX:Number;
		private var _minY:Number;
		private var _minZ:Number;
		private var _maxX:Number;
		private var _maxY:Number;
		private var _maxZ:Number;

		public function SegmentVO( id:String, mesh:Mesh, boundsMesh:Mesh, boundingBoxes:Array, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			_id = id;
			_mesh = mesh;
			_boundsMesh = boundsMesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
			_minX = minX;
			_minY = minY;
			_minZ = minZ;
			_maxX = maxX;
			_maxY = maxY;
			_maxZ = maxZ;
		}
		
		public function add( collidable:ICollidable ):ICollidable {
			return new SegmentVO(
				_id, _mesh, _boundsMesh, _boundingBoxes,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
		
		
		public function clone():SegmentVO {
			return new SegmentVO( _id, _mesh.clone() as Mesh, ( _boundsMesh ) ? _boundsMesh.clone() as Mesh : null, _boundingBoxes, _minX, _minY, _minZ, _maxX, _maxY, _maxZ );
		}
		
		public function get id():String {
			return _id;
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

		public function get x():Number {
			return ( useBoundsMesh ) ? _boundsMesh.x : _mesh.x;
		}
		
		public function get y():Number {
			return ( useBoundsMesh ) ? _boundsMesh.y : _mesh.y;
		}
		
		public function set z( val:Number ):void {
			_mesh.z = _z = val;
			if ( _boundsMesh ) {
				_boundsMesh.z = val;
			}
		}
		
		public function get z():Number {
			return ( useBoundsMesh ) ? _boundsMesh.z : _z;
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
