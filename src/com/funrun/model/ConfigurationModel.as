package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ConfigurationModel stores information related
	 * to FlashVars and other configuration
	 * data which is typically needed on
	 * a global basis.
	 *
	 * @author CJ Cenizal.
	 */
	public class ConfigurationModel extends Actor {
		
		public var fbAccessToken:String;
		public var fbAppId:String;
		public var playerioGameId:String;
		public var playerioPartnerId:String;
		
		public function ConfigurationModel() {
			super();
		}
	}
}
