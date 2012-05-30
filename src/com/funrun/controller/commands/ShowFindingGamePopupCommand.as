package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.constants.PopupTypes;
	import com.funrun.model.vo.ResultsPopupVO;
	import com.funrun.view.components.FindingGamePopup;
	import com.funrun.view.components.Popup;
	import com.funrun.view.components.ResultsPopup;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowFindingGamePopupCommand extends Command {
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		override public function execute():void {
			addPopupRequest.dispatch( new FindingGamePopup() );
		}
	}
}
