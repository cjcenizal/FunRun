package com.funrun.services {

	public class BlocksJsonService extends AbstractJsonService {
		
		[ Embed( source = "external/embed/data/blocks.json", mimeType = "application/octet-stream" ) ]
		private const JsonData:Class;
		
		public function BlocksJsonService() {
			read( JsonData );
		}
	}
}
