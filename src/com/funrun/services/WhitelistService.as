package com.funrun.services {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	public class WhitelistService extends AbstractJsonService implements IWhitelistService {
		
		private var _ids:Array;
		private var _loader:URLLoader;
		private var _onLoadedSignal:Signal;
		private var _isLoaded:Boolean = false;
		
		public function WhitelistService() {
			_ids = [];
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, onLoaded );
			_onLoadedSignal = new Signal();
		}
		
		public function load():void {
			_loader.load( new URLRequest( "data/whitelist.json" ) );
		}
		
		private function onLoaded( e:Event ):void {
			readString( e.target.data );
			var people:Array = data[ "list" ];
			for ( var i:int = 0; i < people.length; i++ ) {
				add( people[ i ][ "id" ] );
			}
			_isLoaded = true;
			_onLoadedSignal.dispatch();
		}
			
		public function add( id:Number ):void {
			_ids.push( id );
		}
		
		public function passes( id:String ):Boolean {
			var len:int = _ids.length;
			for ( var i:int = 0; i < len; i++ ) {
				if ( ( _ids[ i ] as Number ).toString() == id ) {
					return true;
				}
			}
			return false;
		}
		
		public function get onLoadedSignal():Signal {
			return _onLoadedSignal;
		}
		
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
	}
}
