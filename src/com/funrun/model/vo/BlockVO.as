package com.funrun.model.vo {
	
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
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
		private var _boundsMin:Vector3D;
		private var _boundsMax:Vector3D;
		
		public var mesh:Mesh;
		
		public function BlockVo( id:String, filename:String, faces:Object, boundsMin:Vector3D, boundsMax:Vector3D ) {
			_id = id;
			_filename = filename;
			_faces = faces;
			_boundsMin = boundsMin;
			_boundsMax = boundsMax;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get filename():String {
			return _filename;
		}
		
		public function get boundsMin():Vector3D {
			return _boundsMin;
		}
		
		public function get boundsMax():Vector3D {
			return _boundsMax;
		}
		
		public function getEventAtFace( f:String ):String {
			var face:String = TRANSLATIONS[ f ];
			return _faces[ face ] || _faces[ 'all' ];
		}
		
		public function hasAnyEvent( events:Array ):Boolean {
			for ( var i:int = 0; i < events.length; i++ ) {
				for ( var face:String in _faces ) {
					if ( events[ i ] == _faces[ face ] ) {
						return true;
					}
				}
			}
			return false;
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
