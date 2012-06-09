package com.funrun.services {
	import org.osflash.signals.Signal;

	public class WhitelistOpenService implements IWhitelistService {
		
		public function WhitelistOpenService() {
		}

		public function add( id:Number ):void {
		}
		
		public function load():void {
		}

		public function passes( id:String ):Boolean {
			return true;
		}
		
		public function get onLoadedSignal():Signal {
			return null;
		}
		
		public function get isLoaded():Boolean {
			return true;
		}
	}
}
