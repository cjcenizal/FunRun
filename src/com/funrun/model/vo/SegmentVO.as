package com.funrun.model.vo {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.cenizal.physics.collisions.ICollidable;

	public class SegmentVo extends CollidableVo implements ICollidable {
		
		public static var useBoundsMesh:Boolean = false;
		
		public var id:int;
		private var _filename:String;
		private var _mesh:Mesh;
		private var _boundsMesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;
		private var _points:Array;
		private var _pointsObj:Object;

		public function SegmentVo( filename:String, mesh:Mesh, boundsMesh:Mesh, boundingBoxes:Array, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			super( 0, 0, 0, minX, minY, minZ, maxX, maxY, maxZ );
			_filename = filename;
			_mesh = mesh;
			_boundsMesh = boundsMesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
		}
		
		override public function add( collidable:ICollidable ):ICollidable {
			return new SegmentVo(
				_filename, _mesh, _boundsMesh, _boundingBoxes,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
		
		public function clone():SegmentVo {
			var segment:SegmentVo = new SegmentVo( _filename, _mesh.clone() as Mesh, ( _boundsMesh ) ? _boundsMesh.clone() as Mesh : null, _boundingBoxes, _minX, _minY, _minZ, _maxX, _maxY, _maxZ );
			segment.storePoints( _points );
			return segment;
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
		
		public function getBoundingBoxAt( index:int ):BoundingBoxVo {
			return _boundingBoxes[ index ];
		}
		
		public function storePoints( points:Array ):void {
			_points = points;
			_pointsObj = {};
			for ( var i:int = 0; i < numPoints; i++ ) {
				var point:PointVo = getPointAt( i );
				_pointsObj[ point.id ] = point;
			}
		}
		
		public function get numPoints():int {
			return ( _points ) ? _points.length : 0;
		}
		
		public function getPointAt( index:int ):PointVo {
			return _points[ index ];
		}
		
		public function getPoint( id:int ):PointVo {
			return _pointsObj[ id ];
		}
		
		public function get filename():String {
			return _filename;
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
	}
}
