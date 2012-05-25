package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.constants.PopupTypes;
	import com.funrun.model.vo.ResultsPopupVO;
	import com.funrun.view.components.Popup;
	import com.funrun.view.components.ResultsPopup;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowResultsPopupCommand extends Command {
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		override public function execute():void {
			addPopupRequest.dispatch( new ResultsPopup(
				new ResultsPopupVO( "You ran " + distanceModel.distanceString() + " feet!" ) ) );
		}
	}
}
