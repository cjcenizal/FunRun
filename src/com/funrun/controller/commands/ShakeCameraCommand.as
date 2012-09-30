package com.funrun.controller.commands
{
	import com.funrun.model.vo.ShakeCameraVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShakeCameraCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:ShakeCameraVo;
		
		override public function execute():void {
			// Tell CameraModel to set tween targets and durations.
			// UpdateCameraCommand will update it until it's done shaking.
		}
	}
}