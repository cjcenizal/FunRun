package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Track;
	import com.funrun.model.state.ShowBoundsState;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddPlayerCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			// Add placeable.
			addPlaceableRequest.dispatch( playerModel );
			
			// Add mesh.
			var player:Mesh = ( showBoundsState.showBounds )
				? new Mesh( new CubeGeometry( 100, Track.PLAYER_HALF_SIZE * 2, 100 ), Materials.DEBUG_PLAYER )
				: new Mesh( new CylinderGeometry( Track.PLAYER_RADIUS * .9, Track.PLAYER_RADIUS, Track.PLAYER_HALF_SIZE * 2 ), Materials.DEBUG_PLAYER );
			playerModel.mesh = player;
			addObjectToSceneRequest.dispatch( player );
		}
	}
}
