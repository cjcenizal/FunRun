package com.funrun.game.model.data {
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;

	public class ObstacleData {

		private var _mesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;
		private var _z:Number = 0;

		public function ObstacleData( mesh:Mesh, boundingBoxes:Array ) {
			_mesh = mesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
		}
		
		public function clone():ObstacleData {
			return new ObstacleData( _mesh.clone() as Mesh, _boundingBoxes );
		}
		
		/**
		 * Get this obstacle's mesh.
		 * @return The original.
		 */
		public function get mesh():Mesh {
			return _mesh;
		}
		
		public function get numBoundingBoxes():int {
			return _numBoundingBoxes;
		}
		
		public function getBoundingBoxAt( index:int ):BoundingBoxData {
			return _boundingBoxes[ index ];
		}
		
		public function set z( val:Number ):void {
			_mesh.z = _z = val;
		}
		
		public function get z():Number {
			return _z;
		}
		
		public function get bounds():BoundingVolumeBase {
			return _mesh.bounds;
		}
	}
}
