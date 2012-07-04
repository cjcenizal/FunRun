package com.funrun.controller.commands {

	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.OBJParser;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.BlocksParser;
	
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;

	public class LoadBlocksCommand extends AsyncCommand {
		
		[ Embed( source = "external/embed/data/blocks.json", mimeType = "application/octet-stream" ) ]
		private const BlocksJsonData:Class;
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Private vars.
		
		private var _blocksToLoad:int;
		private var _loadedBlocksCount:int = 0;

		override public function execute():void {
			// Store path to obj files.
			var filePath:String = "../external/objs/";
			
			// Parse object to give it meaning.
			var parsedBlocks:BlocksParser = new BlocksParser( new JsonService().read( BlocksJsonData ) );
			
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedBlocks.length;
			_blocksToLoad = len * 2; // Assume one mtl and obj pair per block.
			
			// Set up loading context.
			var context:AssetLoaderContext = new AssetLoaderContext( true, filePath );
			
			// Load the block objs.
			var blockData:BlockVO;
			for ( var i:int = 0; i < len; i++ ) {
				blockData = parsedBlocks.getAt( i );
				// Store in model.
				blocksModel.addBlock( blockData );
				// Load it.
				var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( filePath + blockData.filename ), context, blockData.id, new OBJParser() );
				token.addEventListener( AssetEvent.ASSET_COMPLETE, getOnAssetComplete( blockData ) );
			}
		}

		/**
		 * Listener function for asset complete event on loader
		 */
		private function getOnAssetComplete( blockData:BlockVO ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( event:AssetEvent ):void {
				if ( event.asset.assetType == AssetType.MESH ) {
					// Treat and assign mesh to block.
					var mesh:Mesh = event.asset as Mesh;
					mesh.geometry.scale( 100 ); // Note: scale cannot be performed on mesh when using sub-surface diffuse method.
					mesh.y = -50;
					mesh.rotationY = 180;
					blockData.mesh = mesh;
					// Increment complete count and check if we're done.
					_loadedBlocksCount++;
					if ( _loadedBlocksCount == _blocksToLoad ) {
						trace("load blocks done");
						completeCallback.call( null, true );
					}
				}
			}
		}
	}
}
