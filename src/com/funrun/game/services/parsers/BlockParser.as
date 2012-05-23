package com.funrun.game.services.parsers {
	
	import com.funrun.game.model.constants.FaceTypes;
	import com.funrun.game.model.vo.BlockVO;

	public class BlockParser {
		
		private const COLLISIONS:String = "hit";
		private const FACES:String = "faces";
		
		public function BlockParser() {
		}
		
		public function parse( data:Object ) {
			var id:String = new IdParser( data ).id;
			var filename:String = new FilenameParser( data ).filename;
			var collisions:Array = [];
			var collisionsData:Array = data[ COLLISIONS ];
			if ( collisionsData ) {
				for ( var i:int = 0; i < collisionsData.length; i++ ) {
					if ( collisionsData[ i ] == FaceTypes.ALL ) {
						collisions[ FaceTypes.TOP ] = true;
						collisions[ FaceTypes.BOTTOM ] = true;
						collisions[ FaceTypes.LEFT ] = true;
						collisions[ FaceTypes.RIGHT ] = true;
						collisions[ FaceTypes.FRONT ] = true;
						collisions[ FaceTypes.BACK ] = true;
					} else {
						collisions[ collisionsData[ i ] ] = true;
					}
				}
			}
			var numFaces:int = 0;
			var faces:Object = data[ FACES ] || {};
			for ( var key:String in faces ) {
				numFaces++;
			}
			return new BlockVO( id, filename, collisions, faces, numFaces );
		}
	}
}