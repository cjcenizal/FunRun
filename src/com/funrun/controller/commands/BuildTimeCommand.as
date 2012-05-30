package com.funrun.controller.commands {

	import com.funrun.model.TimeModel;

	import org.robotlegs.mvcs.Command;

	public class BuildTimeCommand extends Command {

		[Inject]
		public var timeModel:TimeModel;

		override public function execute():void {
			timeModel.stage = contextView.stage;
			timeModel.init();
		}
	}
}
