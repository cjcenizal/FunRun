package com.funrun.game.model.data {
	import away3d.entities.Mesh;

	public class ObstacleData {

		private var _mesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;

		public function ObstacleData( mesh:Mesh, boundingBoxes:Array ) {
			_mesh = mesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
		}
		
		public function getBoundingBoxAt( index:int ):BoundingBoxData {
			return _boundingBoxes[ index ];
		}
		
		/**
		 * Get this obstacle's mesh.
		 * @return A clone of the original.
		 */
		public function get mesh():Mesh {
			return _mesh.clone() as Mesh;
		}
		
		public function get numBoundingBoxes():int {
			return _numBoundingBoxes;
		}
	}
}
