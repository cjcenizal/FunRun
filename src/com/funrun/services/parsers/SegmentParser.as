package com.funrun.services.parsers {
	
	import com.funrun.model.collision.BlockData;
	
	public class SegmentParser extends AbstractParser {
		
		private const BLOCKS:String = "blocks";
		private const PITS:String = "pits";
		private const FLIP:String = "flip";
		private const ACTIVE:String = "active";
		private const TYPE:String = "type";
		
		private var _id:String;
		private var _blocks:Array;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _depth:int = 0;
		private var _flip:Boolean = false;
		private var _active:Boolean = false;
		private var _type:String;
		
		public function SegmentParser( data:Object ) {
			super( data );
			_id = new IdParser( data ).id;
			_flip = data[ FLIP ];
			_active = data[ ACTIVE ];
			_type = data[ TYPE ];
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
		
		public function get active():Boolean {
			return _active;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function getBlockAt( index:int ):BlockData {
			return _blocks[ index ];
		}
		
	}
}