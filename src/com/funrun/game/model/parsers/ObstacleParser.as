package com.funrun.game.model.parsers
{
	public class ObstacleParser extends AbstractParser
	{
		
		private const BLOCKS:String = "blocks";
		
		private var _id:String;
		private var _blocks:Array;
		
		public function ObstacleParser( data:Object )
		{
			super( data );
			_id = new IdParser( data ).id;
			_blocks = [];
			var blocks:Array = data[ BLOCKS ];
			var len:int = blocks.length;
			for ( var i:int = 0; i < len; i++ ) {
				_blocks.push( new ObstacleBlockParser( blocks[ i ] ) );
			}
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get numBlocks():int {
			return _blocks.length;
		}
		
		public function getBlockAt( index:int ):ObstacleBlockParser {
			return _blocks[ index ];
		}
	}
}