package com.funrun.controller.commands {

	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		override public function execute():void {
			// Update track.
			var speed:int = 0;
			if ( observerModel.direction < 0 ) {
				speed = -50;
			} else if ( observerModel.direction > 0 ) {
				speed = 50;
			}
			
			observerModel.position += speed;
			playerModel.positionZ += speed;
			playerModel.updateMeshPosition();
			updateTrackRequest.dispatch( new UpdateTrackPayload( -speed, observerModel.position ) );
			
			// Update camera.
			view3DModel.cameraZ = observerModel.position;
			view3DModel.lookAt( playerModel.getMeshPosition() );
			view3DModel.update();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
