package com.funrun.model.vo {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.constants.BlockTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.services.parsers.SegmentParser;
	import com.funrun.model.collision.BlockData;
	import com.funrun.model.collision.BoundingBoxData;

	public class SegmentVO {

		private var _type:String;
		private var _mesh:Mesh;
		private var _boundingBoxes:Array;
		private var _numBoundingBoxes:int;
		private var _z:Number = 0;
		private var _minX:Number;
		private var _minY:Number;
		private var _minZ:Number;
		private var _maxX:Number;
		private var _maxY:Number;
		private var _maxZ:Number;

		public function SegmentVO( type:String, mesh:Mesh, boundingBoxes:Array, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			_type = type;
			_mesh = mesh;
			_boundingBoxes = boundingBoxes;
			_numBoundingBoxes = ( _boundingBoxes ) ? _boundingBoxes.length : 0;
			_minX = minX;
			_minY = minY;
			_minZ = minZ;
			_maxX = maxX;
			_maxY = maxY;
			_maxZ = maxZ;
		}
		
		public function clone():SegmentVO {
			return new SegmentVO( _type, _mesh.clone() as Mesh, _boundingBoxes, _minX, _minY, _minZ, _maxX, _maxY, _maxZ );
		}
		
		/**
		 * Get this obstacle's type (floor or obstacle).
		 * @return The original.
		 */
		public function get type():String {
			return _type;
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

		public function get x():Number {
			return _mesh.x;
		}
		
		public function get y():Number {
			return _mesh.y;
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
