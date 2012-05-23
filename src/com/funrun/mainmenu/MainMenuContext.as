package com.funrun.mainmenu {

	import com.funrun.mainmenu.controller.signals.EnableMainMenuOptionsRequest;
	import com.funrun.mainmenu.controller.signals.DisableMainMenuOptionsRequest;
	import com.funrun.mainmenu.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.signals.StopRunningMainMenuRequest;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	import org.robotlegs.utilities.modularsignals.ModularSignalContext;

	public class MainMenuContext extends ModularSignalContext {

		public function MainMenuContext( contextView:DisplayObjectContainer ) {
			super( contextView );
		}

		override public function startup():void {
			// Map signals.
			injector.mapSingleton( StopRunningMainMenuRequest );
			injector.mapSingleton( StartRunningMainMenuRequest );
			injector.mapSingleton( EnableMainMenuOptionsRequest );
			injector.mapSingleton( DisableMainMenuOptionsRequest );
			
			// Map views to mediators.
			mediatorMap.mapView( MainMenuModule, MainMenuMediator );
			
			super.startup();
		}
	}
}
