package com.funrun.model {
	
	import com.funrun.model.vo.BlockVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlocksModel extends Actor {
		
		private var _blocks:Object;
		
		public function BlocksModel() {
			super();
			_blocks = {};
		}
		
		public function addBlock( block:BlockVo ):void {
			_blocks[ block.id ] = block;
		}
		
		public function getBlock( id:String ):BlockVo {
			return _blocks[ id ];
		}
	}
}
