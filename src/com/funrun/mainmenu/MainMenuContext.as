package com.funrun.mainmenu {
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	public class MainMenuContext extends ModuleContext
	{
		
		public function MainMenuContext( contextView:DisplayObjectContainer ) {
			super( contextView );
		}
		
		override public function startup():void {
			// Map views to mediators.
			mediatorMap.mapView( MainMenuModule, MainMenuMediator );
			
			super.startup();
		}
	}
}
