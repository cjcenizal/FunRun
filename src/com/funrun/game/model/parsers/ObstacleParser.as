package com.funrun.game.model.parsers
{
	import com.funrun.game.model.ObstacleVO;

	public class ObstacleParser extends AbstractParser
	{
		
		private const BLOCKS:String = "blocks";
		
		private var _id:String;
		private var _blocks:Array;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _depth:int = 0;
		
		public function ObstacleParser( data:Object )
		{
			super( data );
			_id = new IdParser( data ).id;
			_blocks = [];
			var blocksDeep:Array = data[ BLOCKS ];
			var blocksWide:Array;
			var blocksHigh:Array;
			_depth = blocksDeep.length;
			for ( var z:int = 0; z < _depth; z++ ) {
				blocksWide = blocksDeep[ z ];
				_width = Math.max( _width, blocksWide.length );
				for ( var x:int = 0; x < _width; x++ ) {
					blocksHigh = blocksWide[ x ];
					_height = Math.max( _height, blocksHigh.length );
					for ( var y:int = 0; y < _height; y++ ) {
						_blocks.push( new ObstacleVO( blocksHigh[ y ], x, y, z ) );
					}
				}
			}
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get numBlocks():int {
			return _blocks.length;
		}
		
		public function getBlockAt( index:int ):ObstacleVO {
			return _blocks[ index ];
		}
	}
}