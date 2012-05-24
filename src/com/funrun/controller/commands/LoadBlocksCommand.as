package com.funrun.controller.commands
{
	import com.funrun.model.BlocksModel;
	import com.funrun.model.IGeosModel;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.services.BlocksJsonService;
	import com.funrun.services.parsers.BlockParser;
	import com.funrun.services.parsers.BlocksParser;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadBlocksCommand extends Command
	{	
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var geosModel:IGeosModel;
		
		[Inject]
		public var service:BlocksJsonService;
		
		override public function execute():void {
			var blocks:BlocksParser = new BlocksParser( service.data );
			var len:int = blocks.length;
			var block:BlockVO;
			for ( var i:int = 0; i < len; i++ ) {
				block = blocks.getAt( i );
				// Apply geo to block.
				block.geo = geosModel.getGeo( block.id );
				blocksModel.addBlock( block );
			}
		}
	}
}