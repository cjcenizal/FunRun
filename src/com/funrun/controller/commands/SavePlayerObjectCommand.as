package com.funrun.controller.commands {

	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Stats;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.PlayerioPlayerObjectService;
	
	import org.robotlegs.mvcs.Command;

	public class SavePlayerObjectCommand extends Command {
		
		// State.
		[Inject]
		public var onlineState:OnlineState;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var playerioPlayerObjectService:PlayerioPlayerObjectService;
		
		override public function execute():void {
			if ( onlineState.isOnline ) {
				var key:String, val:*;
				for ( var i:int = 0; i < Stats.KEYS.length; i++ ) {
					key = Stats.KEYS[ i ];
					playerioPlayerObjectService.playerObject[ key ] = playerModel.properties[ key ];
				}
				playerioPlayerObjectService.save();
			}
		}
	}
}
