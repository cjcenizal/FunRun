package com.funrun.services {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.ByteArray;
	
	public class JsonService {
		
		public function JsonService() {
		}
		
		public function read( JsonData:Class ):Object {
			var ba:ByteArray = new JsonData() as ByteArray;
			return JSON.decode( ba.readUTFBytes( ba.length ) );
		}
		
		public function readString( jsonData:String ):Object {
			return JSON.decode( jsonData );
		}
	}
}
