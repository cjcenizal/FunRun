package com.funrun.game.services {
	
	public class ObstaclesJsonService extends AbstractJsonService {
		
		[ Embed( source = "data/obstacles.json", mimeType = "application/octet-stream" ) ]
		private const JsonData:Class;
		
		public function ObstaclesJsonService() {
			read( JsonData );
		}
	}
}
