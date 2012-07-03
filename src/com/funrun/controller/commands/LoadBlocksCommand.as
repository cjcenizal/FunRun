package com.funrun.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.OBJParser;
	import away3d.loaders.parsers.Parsers;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.IGeosModel;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.services.BlocksJsonService;
	import com.funrun.services.parsers.BlocksParser;
	
	import flash.net.URLRequest;
	
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
			Parsers.enableAllBundled();
			var context:AssetLoaderContext = new AssetLoaderContext( true, "../objs/" );
			
			var blocks:BlocksParser = new BlocksParser( service.data );
			var len:int = blocks.length;
			var block:BlockVO;
			for ( var i:int = 0; i < len; i++ ) {
				block = blocks.getAt( i );
				// Apply geo to block.
				//block.geo = geosModel.getGeo( block.id );
				blocksModel.addBlock( block );
				var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( "../objs/" + block.filename ), context, block.id, new OBJParser() );
				token.addEventListener( AssetEvent.ASSET_COMPLETE, getOnAssetComplete( block ) );
			}
		}
		
		/**
		 * Listener function for asset complete event on loader
		 */
		private function getOnAssetComplete( block:BlockVO ):Function {
			return function( event:AssetEvent ):void {
				trace("name: " + event.asset.name);
				trace("assetNamespace: " + event.asset.assetNamespace);
				trace("assetFullPath: " + event.asset.assetFullPath);
				if ( event.asset.assetType == AssetType.MESH ) {
					var mesh:Mesh = event.asset as Mesh;
					mesh.geometry.scale( 100 ); //TODO scale cannot be performed on mesh when using sub-surface diffuse method
					mesh.y = -50;
					mesh.rotationY = 180;
					block.mesh = mesh;
					//mesh.material.lightPicker = lightPicker;
					//scene.addChild( mesh );
				}
			}
		}
	}
}