package com.funrun.controller.commands {
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.state.ProductionState;
	import com.funrun.services.JsonService;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadConfigCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// State.
		
		[Inject]
		public var productionState:ProductionState;
		
		// Private vars.
		
		private var _loader:URLLoader;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/config.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			var obj:Object = new JsonService().readString( data );
			productionState.isExploration = obj.isExploration;
			dispatchComplete( true );
		}
		
	}
}
