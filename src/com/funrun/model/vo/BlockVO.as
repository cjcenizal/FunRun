package com.funrun.model.vo {
	
	import away3d.entities.Mesh;
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.model.constants.FaceTypes;
	
	public class BlockVO {
		
		private var _id:String;
		private var _filename:String;
		private var _collisions:Array;
		private var _faces:Object;
		private var _numFaces:int = 0;
		
		//public var geo:PrimitiveBase;
		public var mesh:Mesh;
		
		public function BlockVO(
			id:String,
			filename:String,
			collisions:Array,
			faces:Object,
			numFaces:int
		) {
			_id = id;
			_filename = filename;
			_collisions = collisions;
			_faces = faces;
			_numFaces = numFaces;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get filename():String {
			return _filename;
		}
		
		public function get numFaces():int {
			return _numFaces;
		}
		
		public function getEventAtFace( face:String ):String {
			return _faces[ face ] || _faces[ FaceTypes.ALL ];
		}
		
		public function doesFaceCollide( face:String ):Boolean {
			return _collisions[ face ];
		}
	}
}
