package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.StoreFloorRequest;
	import com.funrun.controller.signals.StoreObstacleRequest;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.ObstaclesListParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	/**
	 * Parse a json file and store a mesh constructed out of template blocks.
	 */
	public class LoadObstaclesCommand extends AsyncCommand {
		
		// Commands.
		
		[Inject]
		public var storeFloorRequest:StoreFloorRequest;
		
		[Inject]
		public var storeObstacleRequest:StoreObstacleRequest;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "obstacles/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			// TO-DO: Eventually this will be encoded externally just like all other obstacles.
			// Store floor first.
			storeFloorRequest.dispatch();
			
			// Load list of obstacles.
			_loader = new URLLoader( new URLRequest( 'data/obstacles.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse list of obstacles.
			var parsedObstaclesList:ObstaclesListParser = new ObstaclesListParser( new JsonService().readString( data ) );
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedObstaclesList.length;
			_countTotal = len;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load each obstacle, construct it, and store the mesh.
				for ( var i:int = 0; i < len; i++ ) {
					var filename:String = parsedObstaclesList.getAt( i );
					var loader:URLLoader = new URLLoader( new URLRequest( _filePath + filename ) );
					loader.addEventListener( Event.COMPLETE, getOnObstacleLoaded( filename ) );
				}
			}
		}
		
		private function getOnObstacleLoaded( filename:String ):Function {
			var completeCallback:Function = this.dispatchComplete;
			var storeObstacleRequest:Signal = this.storeObstacleRequest;
			return function( e:Event ):void {
				var data:String = ( e.target as URLLoader ).data;
				var json:Object = new JsonService().readString( data );
				// Construct and store obstacle.
				storeObstacleRequest.dispatch( json );
				// Increment complete count and check if we're done.
				_countLoaded++;
				if ( _countLoaded == _countTotal ) {
					completeCallback.call( null, true );
				}
			}
		}
	}
}