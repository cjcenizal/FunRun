package com.funrun.services {
	import org.osflash.signals.Signal;
	
	import playerio.Client;

	public class WhitelistOpenService implements IWhitelistService {
		
		private var _onPassSignal:Signal;
		private var _onFailSignal:Signal;
		private var _onErrorSignal:Signal;
		
		public function WhitelistOpenService() {
			_onPassSignal = new Signal();
			_onFailSignal = new Signal();
			_onErrorSignal = new Signal();
		}
		
		public function isIdInTable( id:String, tableName:String, client:Client ):void {
			_onPassSignal.dispatch();
		}
		
		public function get onPassSignal():Signal {
			return _onPassSignal;
		}
		
		public function get onFailSignal():Signal {
			return _onFailSignal;
		}
		
		public function get onErrorSignal():Signal {
			return _onErrorSignal;
		}
		
		public function get error():Error {
			return null;
		}
	}
}
