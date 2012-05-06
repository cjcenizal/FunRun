package com.funrun.game.model {
	
	import away3d.primitives.PrimitiveBase;
	
	import com.funrun.game.model.parsers.BlockParser;
	
	public class BlocksModel {
		
		private var _blocks:Object;
		
		public function BlocksModel() {
			_blocks = {};
		}
		
		public function addBlock( block:BlockParser ):void {
			_blocks[ block.id ] = block;
		}
		
		public function getBlock( id:String ):BlockParser {
			return _blocks[ id ];
		}
	}
}
