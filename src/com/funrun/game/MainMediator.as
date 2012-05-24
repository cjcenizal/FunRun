package com.funrun.game {
	
	import com.funrun.game.controller.commands.ExternalShowGameModuleCommand;
	import com.funrun.game.controller.events.InternalShowMainMenuRequest;
	import com.funrun.game.controller.events.StartRunningGameRequest;
	import com.funrun.game.controller.events.StopRunningGameRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowGameModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MainView;
		
		override public function onRegister():void {
			view.build();
			// Listen for events telling us which view to display (main menu, game, etc).
		}
	}
}
