package com.funrun.services {
	
	public class LoadSegmentsJsonService extends AbstractJsonService {
		
		[ Embed( source = "external/embed/data/obstacles.json", mimeType = "application/octet-stream" ) ]
		private const JsonData:Class;
		
		public function LoadSegmentsJsonService() {
			read( JsonData );
		}
	}
}
