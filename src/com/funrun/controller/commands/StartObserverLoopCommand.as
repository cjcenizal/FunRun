package com.funrun.controller.commands {
	
	import com.funrun.model.View3DModel;
	import com.funrun.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var cameraModel:View3DModel;
		
		override public function execute():void {
			// Set camera.
			cameraModel.cameraX = 0;
			cameraModel.cameraY = 100;
			cameraModel.update();
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
		}
	}
}
