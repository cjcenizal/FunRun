package com.funrun.game.controller.commands
{
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.services.BlocksJson;
	import com.funrun.game.services.BlocksJsonService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadBlocksCommand extends Command
	{	
		[Inject]
		public var model:BlocksModel;
		
		[Inject]
		public var service:BlocksJsonService;
		
		override public function execute():void {
			var blocks:Array = service.getList();
			var len:int = blocks.length;
			var blockData:BlocksJson;
			for ( var i:int = 0; i < len; i++ ) {
				blockData = new BlocksJson( blocks[ i ] );
			}
		}
	}
}