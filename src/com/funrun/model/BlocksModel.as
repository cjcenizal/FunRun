package com.funrun.model {
	
	import com.funrun.model.vo.BlockVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlocksModel extends Actor {
		
		private var _blocks:Object;
		private var _blocksArr:Array;
		
		public function BlocksModel() {
			super();
			_blocks = {};
			_blocksArr = [];
		}
		
		public function addBlock( block:BlockVo ):void {
			_blocks[ block.id ] = block;
			_blocksArr.push( block );
		}
		
		public function getBlock( id:String ):BlockVo {
			return _blocks[ id ];
		}
		
		public function getBlockAt( index:int ):BlockVo {
			return _blocksArr[ index ];
		}
		
		public function get count():int {
			return _blocksArr.length;
		}
	}
}
