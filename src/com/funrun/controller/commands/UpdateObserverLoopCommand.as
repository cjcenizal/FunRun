package com.funrun.controller.commands {

	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.ObservationModel;
	import com.funrun.model.View3DModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var observationModel:ObservationModel;
		
		// Commands.
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		override public function execute():void {
			// Position camera.
			view3DModel.lookAt( new Vector3D() );
			
			// Update track.
			var speed:int = 0;
			if ( observationModel.direction < 0 ) {
				speed = -50;
			} else if ( observationModel.direction > 0 ) {
				speed = 50;
			}
			
			observationModel.position += speed;
			updateTrackRequest.dispatch( new UpdateTrackPayload( -speed, observationModel.position ) );
			
			// Update camera.
			view3DModel.cameraZ = observationModel.position;
			view3DModel.update();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
