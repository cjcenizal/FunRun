package com.funrun.game.model.parsers
{
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.game.model.constants.FaceTypes;

	public class BlockParser extends AbstractParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		
		private var _id:String;
		private var _filename:String;
		private var _collisions:Array;
		private var _faces:Object;
		private var _numFaces:int = 0;
		
		public var geo:PrimitiveBase;
		
		public function BlockParser( data:Object ) {
			super( data );
			_id = new IdParser( data ).id;
			_filename = new FilenameParser( data ).filename;
			_collisions = [];
			var collisions:Array = data[ COLLISIONS ];
			if ( collisions ) {
				for ( var i:int = 0; i < collisions.length; i++ ) {
					if ( collisions[ i ] == FaceTypes.ALL ) {
						_collisions[ FaceTypes.TOP ] = true;
						_collisions[ FaceTypes.BOTTOM ] = true;
						_collisions[ FaceTypes.LEFT ] = true;
						_collisions[ FaceTypes.RIGHT ] = true;
						_collisions[ FaceTypes.FRONT ] = true;
						_collisions[ FaceTypes.BACK ] = true;
					} else {
						_collisions[ collisions[ i ] ] = true;
					}
				}
			}
			_faces = data[ FACES ] || {};
			for ( var key:String in _faces ) {
				_numFaces++;
			}
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