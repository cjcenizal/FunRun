package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.model.vo.PlayerioErrorVO;
	import com.funrun.view.components.PlayerioErrorPopupView;
	
	import org.robotlegs.mvcs.Command;

	public class ShowPlayerioErrorPopupCommand extends Command {

		[Inject]
		public var error:PlayerioErrorVO;
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		override public function execute():void {
			addPopupRequest.dispatch( new PlayerioErrorPopupView( error ) );
		}
	}
}
