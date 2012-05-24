package com.funrun.services {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.ByteArray;
	
	public class AbstractJsonService {
		
		public var data:Object;
		
		public function AbstractJsonService() {
		}
		
		protected function read( JsonData:Class ):void {
			var ba:ByteArray = new JsonData() as ByteArray;
			data = JSON.decode( ba.readUTFBytes( ba.length ) );
		}
	}
}
