package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.vo.PlayerioErrorVo;
	import com.funrun.view.components.PlayerioErrorPopupView;
	
	import org.robotlegs.mvcs.Command;

	public class ShowPlayerioErrorPopupCommand extends Command {

		[Inject]
		public var error:PlayerioErrorVo;
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		override public function execute():void {
			addPopupRequest.dispatch( new PlayerioErrorPopupView( error ) );
		}
	}
}
