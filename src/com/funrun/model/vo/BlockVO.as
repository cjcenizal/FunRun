package com.funrun.model.vo {
	
	import away3d.entities.Mesh;
	
	public class BlockVo {
		
		private static const TRANSLATIONS:Object = {};
		TRANSLATIONS[ 'front' ] = 'f';
		TRANSLATIONS[ 'back' ] = 'a';
		TRANSLATIONS[ 'left' ] = 'l';
		TRANSLATIONS[ 'right' ] = 'r';
		TRANSLATIONS[ 'top' ] = 't';
		TRANSLATIONS[ 'bottom' ] = 'b';
		
		private var _id:String;
		private var _filename:String;
		private var _faces:Object;
		
		//public var geo:PrimitiveBase;
		public var mesh:Mesh;
		
		public function BlockVo( id:String, filename:String, faces:Object ) {
			_id = id;
			_filename = filename;
			_faces = faces;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get filename():String {
			return _filename;
		}
		
		public function getEventAtFace( f:String ):String {
			var face:String = TRANSLATIONS[ f ];
			return _faces[ face ] || _faces[ 'all' ];
		}
		
		public function toString():String {
			var str:String = _id + ": {";
			for ( var key:String in _faces ) {
				str += " " + key + " : " + _faces[ key ] + " ,";
			}
			str += "}";
			return str;
		}
	}
}
