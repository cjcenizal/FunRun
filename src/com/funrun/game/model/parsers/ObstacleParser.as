package com.funrun.game.model.parsers
{

	public class ObstacleParser extends AbstractParser
	{
		
		private const BLOCKS:String = "blocks";
		private const PITS:String = "pits";
		
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
			
			var blocksDeep:Array, blocksWide:Array, blocksHigh:Array;
			var z:int, x:int, y:int;
			
			// Parse above-ground blocks.
			blocksDeep = data[ BLOCKS ];
			if ( blocksDeep ) {
				_depth = blocksDeep.length;
				for ( z = 0; z < _depth; z++ ) {
					blocksWide = blocksDeep[ z ];
					_width = Math.max( _width, blocksWide.length );
					for ( x = 0; x < _width; x++ ) {
						blocksHigh = blocksWide[ x ];
						_height = Math.max( _height, blocksHigh.length );
						for ( y = 0; y < _height; y++ ) {
							var block:BlockVO = new BlockVO( blocksHigh[ y ], x, y, z );
							if ( block.id ) {
								_blocks.push( block );
							}
						}
					}
				}
			}
			
			// Parse below-ground blocks (pits).
			blocksDeep = data[ PITS ];
			if ( blocksDeep ) {
				_depth = blocksDeep.length;
				for ( z = 0; z < _depth; z++ ) {
					blocksWide = blocksDeep[ z ];
					_width = Math.max( _width, blocksWide.length );
					for ( x = 0; x < _width; x++ ) {
						blocksHigh = blocksWide[ x ];
						_height = Math.max( _height, blocksHigh.length );
						for ( y = 0; y < _height; y++ ) {
							var posY:int = _height - y;
							var block:BlockVO = new BlockVO( blocksHigh[ y ], x, -posY - 1, z ); // Make sure to invert y to place underground.
							if ( block.id ) {
								_blocks.push( block );
							}
						}
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
		
		public function getBlockAt( index:int ):BlockVO {
			return _blocks[ index ];
		}
	}
}