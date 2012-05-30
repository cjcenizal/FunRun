package com.funrun.controller.commands {

	import com.funrun.model.InterpolationModel;
	import com.funrun.model.constants.TimeConstants;
	
	import org.robotlegs.mvcs.Command;

	public class BuildInterpolationCommand extends Command {

		[Inject]
		public var interpolationModel:InterpolationModel;
		
		override public function execute():void {
			interpolationModel.setIncrement( TimeConstants.INTERPOLATION_INCREMENT );
		}
	}
}
