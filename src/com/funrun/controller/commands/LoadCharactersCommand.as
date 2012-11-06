package com.funrun.controller.commands
{
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.CharacterParser;
	import com.funrun.services.parsers.CharactersListParser;
	import com.funrun.model.constants.Animations;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadCharactersCommand extends AsyncCommand
	{
		
		
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
			_countTotal = len;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load each obstacle, construct it, and store the mesh.
				for ( var i:int = 0; i < len; i++ ) {
					var character:CharacterParser = parsedCharactersList.getAt( i );
					for ( var j:int = 0; j < Animations.IDS.length; j++ ) {
						var loader:URLLoader = new URLLoader( new URLRequest(
							_filePath
							+ character.folder + "/"
							+ character.getAnimationWithId( Animations.IDS[ j ] ) );
						loader.addEventListener( Event.COMPLETE, getOnCharacterLoaded( filename ) );
					}
				}
			}
		}
		
		private function getOnCharacterLoaded( filename:String ):Function {
			var completeCallback:Function = this.dispatchComplete;
			var storeObstacleRequest:Signal = this.storeObstacleRequest;
			return function( e:Event ):void {
				var data:String = ( e.target as URLLoader ).data;
				var json:Object = new JsonService().readString( data );
				// Construct and store obstacle.
				storeObstacleRequest.dispatch( new StoreObstacleVo( filename, json ) );
				// Increment complete count and check if we're done.
				_countLoaded++;
				if ( _countLoaded == _countTotal ) {
					completeCallback.call( null, true );
				}
			}
		}
	}
}