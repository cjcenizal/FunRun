package com.funrun.controller.commands
{
	import org.robotlegs.mvcs.Command;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadStoreCommand extends AsyncCommand
	{
		
		// Private vars.
		
		private var _loader:URLLoader;
		
		override public function execute():void {
			
			// Load list of obstacles.
			_loader = new URLLoader( new URLRequest( 'data/store.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse this intelligently, expecting certain categories, and ways to implement their schemas.
			// Use a switch-case? Or just proactively seek out the data?
			/*
			// Parse list of obstacles.
			var parsedObstaclesList:ObstaclesListParser = new ObstaclesListParser( new JsonService().readString( data ) );
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedObstaclesList.length;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load each obstacle, construct it, and store the mesh.
				for ( var i:int = 0; i < len; i++ ) {
					var filename:String = parsedObstaclesList.getAt( i );
				}
			}*/
		}
	}
}