package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Player;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddPlayerCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		override public function execute():void {
			// Add placeable.
			addPlaceableRequest.dispatch( playerModel );
			
			// Add mesh.
			var player:Mesh = new Mesh( new CubeGeometry( Player.WIDTH, Player.HEIGHT, Player.WIDTH ), Materials.DEBUG_PLAYER );
			playerModel.mesh = player;
			addObjectToSceneRequest.dispatch( player );
		}
	}
}
