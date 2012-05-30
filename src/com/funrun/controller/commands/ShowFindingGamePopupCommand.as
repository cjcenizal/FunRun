package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.view.components.FindingGamePopup;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowFindingGamePopupCommand extends Command {
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		override public function execute():void {
			addPopupRequest.dispatch( new FindingGamePopup() );
		}
	}
}
