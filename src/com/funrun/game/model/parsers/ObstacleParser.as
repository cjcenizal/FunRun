package com.funrun.game.model.parsers {
	
	import com.funrun.game.model.data.BlockData;
	
	public class ObstacleParser extends AbstractParser {
		
		private const BLOCKS:String = "blocks";
		private const PITS:String = "pits";
		private const FLIP:String = "flip";
		
		private var _id:String;
		private var _blocks:Array;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _depth:int = 0;
		private var _flip:Boolean = false;
		
		public function ObstacleParser( data:Object ) {
			super( data );
			_id = new IdParser( data ).id;
			_flip = data[ FLIP ];
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
							var block:BlockData = new BlockData( blocksHigh[ y ], x, y, z );
							if ( block.id ) {
								_blocks.push( block );
							}
						}
					}
				}
			}
			
			// Parse below-ground blocks (pits).
			blocksDeep = data[ PITS ];
			_depth = ( blocksDeep ) ? blocksDeep.length : 0;
			for ( z = 0; z < _depth; z++ ) {
				blocksWide = blocksDeep[ z ];
				_width = ( blocksWide ) ? Math.max( _width, blocksWide.length ) : 0;
				for ( x = 0; x < _width; x++ ) {
					blocksHigh = blocksWide[ x ];
					_height = ( blocksHigh ) ? Math.max( _height, blocksHigh.length ) : 0;
					for ( y = 0; y < _height; y++ ) {
						var posY:int = _height - y;
						var block:BlockData = new BlockData( blocksHigh[ y ], x, -posY, z ); // Make sure to invert y to place underground.
						if ( block.id ) {
							_blocks.push( block );
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
		
		public function get flip():Boolean {
			return _flip;
		}
		
		public function getBlockAt( index:int ):BlockData {
			return _blocks[ index ];
		}
	}
}
