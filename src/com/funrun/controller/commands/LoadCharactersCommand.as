package com.funrun.controller.commands
{
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.data.Skeleton;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.ParserBase;
	
	import com.funrun.model.CharactersModel;
	import com.funrun.model.constants.CharacterAnimations;
	import com.funrun.model.constants.CharacterMaps;
	import com.funrun.model.vo.CharacterVo;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.CharacterParser;
	import com.funrun.services.parsers.CharactersListParser;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadCharactersCommand extends AsyncCommand
	{
		
		// Models.
		
		[Inject]
		public var charactersModel:CharactersModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "characters/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			// Load list of obstacles.
			_loader = new URLLoader( new URLRequest( 'data/characters.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			var parsedCharactersList:CharactersListParser = new CharactersListParser( new JsonService().readString( data ) );
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedCharactersList.length;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load each obstacle, construct it, and store the mesh.
				var context:AssetLoaderContext = new AssetLoaderContext( true, _filePath );
				for ( var i:int = 0; i < len; i++ ) {
					var character:CharacterParser = parsedCharactersList.getAt( i );
					var vo:CharacterVo = new CharacterVo( character.id, character.scale );
					var parser:ParserBase;
					var basePath:String = _filePath + character.folder + "/";
					charactersModel.add( vo );
					// Load model.
					parser = new MD5MeshParser();
					load( basePath + character.model, context, character.id, parser, getOnModelLoaded( vo ) );
					// Load maps.
					for ( var k:int = 0; k < CharacterMaps.IDS.length; k++ ) {
						var mapFile:String = basePath + character.getMapWithId( CharacterMaps.IDS[ k ] );
						var loader:Loader = new Loader();
						loader.load( new URLRequest( mapFile ) );
						loader.contentLoaderInfo.addEventListener( Event.COMPLETE, getOnMapLoaded( vo, CharacterMaps.IDS[ k ] ) );
					}
					// Load animations.
					for ( var j:int = 0; j < CharacterAnimations.IDS.length; j++ ) {
						parser = new MD5AnimParser();
						var looping:Boolean = CharacterAnimations.IS_LOOPING[ CharacterAnimations.IDS[ j ] ];
						load( basePath + character.getAnimationWithId( CharacterAnimations.IDS[ j ] ), context, CharacterAnimations.IDS[ j ], parser, getOnAnimationLoaded( vo, looping ) );
					}
				}
			}
		}
		
		private function load( filename:String, context:AssetLoaderContext, namespace:String, parser:ParserBase, callback:Function ):void {
			var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( filename ), context, namespace, parser );
			token.addEventListener( AssetEvent.ASSET_COMPLETE, callback );
			_countTotal++;
		}
		
		private function getOnModelLoaded( vo:CharacterVo ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( e:AssetEvent ):void {
				
				switch ( e.asset.assetType ) {
					case AssetType.ANIMATION_SET:
						var animationSet:SkeletonAnimationSet = e.asset as SkeletonAnimationSet;
						vo.init( animationSet );
						break;
					
					case AssetType.SKELETON:
						var skeleton:Skeleton = e.asset as Skeleton;
						vo.storeSkeleton( skeleton );
						break;
					
					case AssetType.MESH:
						var mesh:Mesh = e.asset as Mesh;
						vo.storeMesh( mesh );
						// Increment complete count and check if we're done.
						_countLoaded++;
						if ( _countLoaded == _countTotal ) {
							completeCallback.call( null, true );
						}
						break;
				}
			}
		}
		
		private function getOnAnimationLoaded( vo:CharacterVo, looping:Boolean ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( e:AssetEvent ):void {
				switch ( e.asset.assetType ) {
					case AssetType.ANIMATION_STATE:
						var state:SkeletonAnimationState = e.asset as SkeletonAnimationState;
						var namespace:String = e.asset.assetNamespace;
						vo.storeAnimationState( state, namespace, looping );
						// Increment complete count and check if we're done.
						_countLoaded++;
						if ( _countLoaded == _countTotal ) {
							completeCallback.call( null, true );
						}
						break;
				}
			}
		}
		
		private function getOnMapLoaded( vo:CharacterVo, mapId:String ):Function {
			return function( e:Event ):void {
				var bitmap:Bitmap = e.target.content;
				vo.storeMap( mapId, bitmap.bitmapData );
			}
		}
		
	}
}