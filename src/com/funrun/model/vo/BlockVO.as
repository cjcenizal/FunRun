package com.funrun.model.vo {
	
	import away3d.entities.Mesh;
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.model.constants.FaceTypes;
	
	public class BlockVO {
		
		private static const TRANSLATIONS:Object = {};
		TRANSLATIONS[ 'front' ] = 'f';
		TRANSLATIONS[ 'back' ] = 'a';
		TRANSLATIONS[ 'left' ] = 'l';
		TRANSLATIONS[ 'right' ] = 'r';
		TRANSLATIONS[ 'top' ] = 't';
		TRANSLATIONS[ 'bottom' ] = 'b';
		
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
		
		public function getEventAtFace( f:String ):String {
			var face:String = TRANSLATIONS[ f ];
			return _faces[ face ] || _faces[ FaceTypes.ALL ];
		}
		
		public function doesFaceCollide( face:String ):Boolean {
			return _collisions[ face ];
		}
	}
}
