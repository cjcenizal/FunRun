package com.funrun.game.controller.commands
{
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.IGeosModel;
	import com.funrun.game.model.parsers.BlockParser;
	import com.funrun.game.model.parsers.BlocksParser;
	import com.funrun.game.services.BlocksJsonService;
	
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
			var block:BlockParser;
			for ( var i:int = 0; i < len; i++ ) {
				block = blocks.getAt( i );
				// Apply geo to block.
				block.geo = geosModel.getGeo( block.id );
				blocksModel.addBlock( block );
			}
		}
	}
}