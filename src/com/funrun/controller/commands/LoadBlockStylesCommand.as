package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.BlockStylesParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import old.OBJParser;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadBlockStylesCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "blocks";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/block_styles.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse object to give it meaning.
			var parsedStyles:BlockStylesParser = new BlockStylesParser( new JsonService().readString( data ) );
			if ( parsedStyles.length == 0 ) {
				dispatchComplete( true );
			} else {
				// Load the block objs.
				var style:BlockStyleVo, keys:Array, id:String, filename:String;
				for ( var i:int = 0; i < parsedStyles.length; i++ ) {
					style = parsedStyles.getAt( i );
					// Store in model.
					blockStylesModel.add( style );
					keys = style.getKeys();
					// Set up loading context.
					var path:String = _filePath + "/" + style.id + "/";
					var context:AssetLoaderContext = new AssetLoaderContext( true, path);
					for ( var j:int = 0; j < keys.length; j++ ) {
						id = keys[ j ];
						var filenames:Array = style.getFilenames( id );
						// Increment count total.
						_countTotal += filenames.length;
						for ( var k:int = 0; k < filenames.length; k++ ) {
							filename = filenames[ k ];
							// Load it.
							var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( path + filename ), context, id, new old.OBJParser() );
							token.addEventListener( AssetEvent.ASSET_COMPLETE, getOnAssetComplete( style, id ) );
						}
					}
				}
			}
		}
		
		/**
		 * Listener function for asset complete event on loader
		 */
		private function getOnAssetComplete( style:BlockStyleVo, id:String ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( event:AssetEvent ):void {
				if ( event.asset.assetType == AssetType.MESH ) {
					// Treat mesh.
					var mesh:Mesh = event.asset as Mesh;
					// This check is required since mtl files are being loaded and identified as meshes.
					if ( mesh.bounds.min.length > 0 || mesh.bounds.max.length > 0 ) {
						var nameObj:Object = {};
						nameObj[ 'style' ] = style.id;
						nameObj[ 'type' ] = id;
						mesh.name = JSON.stringify( nameObj );
						mesh.geometry.scale( Block.SIZE ); // Note: scale cannot be performed on mesh when using sub-surface diffuse method.
						mesh.rotationY = 180;
						// Store mesh.
						style.addMesh( id, mesh );
						// Increment complete count and check if we're done.
						_countLoaded++;
						if ( _countLoaded == _countTotal ) {
							completeCallback.call( null, true );
						}
					}
				}
			}
		}
	}
}
