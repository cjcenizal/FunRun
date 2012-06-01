package com.funrun.model {
	
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlocksModel extends Actor {
		
		private var _blocks:Object;
		
		public function BlocksModel() {
			super();
			_blocks = {};
		}
		
		public function addBlock( block:BlockVO ):void {
			_blocks[ block.id ] = block;
		}
		
		public function getBlock( id:String ):BlockVO {
			return _blocks[ id ];
		}
	}
}
