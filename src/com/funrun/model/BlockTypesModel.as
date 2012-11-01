package com.funrun.model {
	
	import com.funrun.model.vo.BlockTypeVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlockTypesModel extends Actor {
		
		private var _blocks:Object;
		private var _blocksArr:Array;
		private var _bitmaps:Object;
		
		public function BlockTypesModel() {
			super();
			_blocks = {};
			_blocksArr = [];
			_bitmaps = {};
		}
		
		public function addBlock( block:BlockTypeVo ):void {
			_blocks[ block.id ] = block;
			_blocksArr.push( block );
		}
		
		public function getWithId( id:String ):BlockTypeVo {
			return _blocks[ id ];
		}
		
		public function getBlockIndex( id:String ):int {
			for ( var i:int = 0; i < _blocksArr.length; i++ ) {
				if ( getAt( i ).id == id ) {
					return i;
				}
			}
			return -1;
		}
		
		public function getAt( index:int ):BlockTypeVo {
			return _blocksArr[ index ];
		}
		
		public function get numBlocks():int {
			return _blocksArr.length;
		}
	}
}
