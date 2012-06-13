package com.funrun.controller.commands {
	
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.constants.TimeConstants;
	
	import org.robotlegs.mvcs.Command;

	public class InitModelsCommand extends Command {

		// Models.
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		override public function execute():void {
			// Keyboard.
			keyboardModel.stage = contextView.stage;
			
			// Interpolation.
			interpolationModel.setIncrement( TimeConstants.INTERPOLATION_INCREMENT );

			// Time.
			timeModel.stage = contextView.stage;
			timeModel.init();
		}
	}
}
