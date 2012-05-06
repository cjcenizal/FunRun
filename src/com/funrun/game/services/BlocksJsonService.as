package com.funrun.game.services {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.ByteArray;

	public class BlocksJsonService {
		
		[ Embed( source = "data/blocks.json", mimeType = "application/octet-stream" ) ]
		private const JsonData:Class;
		
		public var data:Object;
		
		public function BlocksJsonService() {
			var ba:ByteArray = new JsonData() as ByteArray;
			data = JSON.decode( ba.readUTFBytes( ba.length ) );
		}
	}
}
