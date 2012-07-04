package com.funrun.services.parsers {
	
	import com.funrun.model.vo.ObstacleBlockVO;

	public class ObstacleParser {
		
		private const ID:String = "id";
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
				_blocks.push( new ObstacleBlockVO(
						block[ ID ],
						block[ X ],
						block[ Y ],
						block[ Z ]
					) );
			}
		}
		
		public function get numBlockData():int {
			return _blocks.length;
		}
		
		public function getBlockDataAt( index:int ):ObstacleBlockVO {
			return _blocks[ index ];
		}
	}
}
