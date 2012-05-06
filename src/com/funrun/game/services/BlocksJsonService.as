package com.funrun.game.services {
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.ByteArray;

	public class BlocksJsonService {
		
		[ Embed( source = "data/blocks.json", mimeType = "application/octet-stream" ) ]
		private const JsonData:Class;
		
		// Standard data format.
		private const DOCS:String = "doc";
		private const AUTHOR:String = "author";
		private const LIST:String = "list";
		
		public var data:Object;
		
		public function BlocksJsonService() {
			var ba:ByteArray = new JsonData() as ByteArray;
			data = JSON.decode( ba.readUTFBytes( ba.length ) );
		}
		
		public function getList():Array {
			return data[ LIST ];
		}
		
		public function getAuthor():Array {
			return data[ AUTHOR ];
		}
		
		public function getDocs():Array {
			return data[ DOCS ];
		}
	}
}
