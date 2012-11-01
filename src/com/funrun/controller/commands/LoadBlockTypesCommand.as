package com.funrun.controller.commands {
	
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.vo.BlockTypeVo;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.BlockStylesParser;
	import com.funrun.services.parsers.BlockTypesParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadBlockTypesCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var blockTypesModel:BlockTypesModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/block_types.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse object to give it meaning.
			var parsedBlocks:BlockTypesParser = new BlockTypesParser( new JsonService().readString( data ) );
			var len:int = parsedBlocks.length;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load the block objs.
				var blockType:BlockTypeVo;
				for ( var i:int = 0; i < len; i++ ) {
					blockType = parsedBlocks.getAt( i );
					// Store in model.
					blockTypesModel.addBlock( blockType );
				}
				dispatchComplete( true );
			}
		}
	}
}
