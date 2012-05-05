package com.funrun.game.model {
	
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	
	public class BlocksModel {
		
		public const EMPTY:String = "EMPTY";
		public const BLOCK:String = "BLOCK";
		private var _blocks:Object;
		
		public function BlocksModel() {
			_blocks = {};
			_blocks[ EMPTY ] = new PlaneGeometry( 1, 1 );
			_blocks[ BLOCK ] = new CubeGeometry( 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE, 1 * Constants.BLOCK_SIZE );
		}
		
		public function addBlock( id:String, block:PrimitiveBase ):void {
			_blocks[ id ] = block;
		}
		
		public function getBlock( id:String ):PrimitiveBase {
			return _blocks[ id ];
		}
	}
}
