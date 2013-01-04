package com.funrun.services.parsers {
	
	import com.funrun.model.vo.ObstacleBlockVo;

	public class ObstacleParser {
		
		private const ID:String = "id";
		private const TYPE:String = "type";
		private const POS:String = "pos";
		private const X:String = "x";
		private const Y:String = "y";
		private const Z:String = "z";
		
		private var _blocks:Array;
		
		public function ObstacleParser( objects:Array ) {
			_blocks = [];
			var len:int = objects.length;
			var block:Object;
			for ( var i:int = 0; i < len; i++ ) {
				block = objects[ i ];
				_blocks.push( new ObstacleBlockVo(
						block[ ID ][ TYPE ],
						block[ ID ][ POS ],
						block[ X ],
						block[ Y ],
						block[ Z ]
					) );
			}
		}
		
		public function get numBlockData():int {
			return _blocks.length;
		}
		
		public function getAt( index:int ):ObstacleBlockVo {
			return _blocks[ index ];
		}
		
	}
}
