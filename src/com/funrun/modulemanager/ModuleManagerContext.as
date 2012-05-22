package com.funrun.modulemanager {
	
	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	
	import flash.events.Event;
	
	import org.robotlegs.utilities.modular.base.ModuleEventDispatcher;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class ModuleManagerContext extends ModuleContext {
		
		private var _moduleEventDispatcher:ModuleEventDispatcher;
		
		/**
		 * Factory method. Provide the Context with the necessary objects to do its work.
		 * Note that the both the injector and reflector are programmed to interfaces
		 * so you can freely change the IoC container and Reflection library you want
		 * to use as long as the 'contract' is fullfilled. See the adapter package
		 * in the RobotLegs source.
		 *
		 * @param contextView DisplayObjectContainer
		 * @param autoStartup Boolean
		 *
		 */
		
		public function ModuleManagerContext( contextView:ModuleContextView ) {
			super( contextView );
			
			var moduleEventDispatcher:ModuleEventDispatcher = new ModuleEventDispatcher();
			setModuleDispatcher( moduleEventDispatcher );
			_moduleEventDispatcher = moduleEventDispatcher;
			
			startup();
		}
		
		/**
		 * Gets called by the framework if autoStartup is true. Here we need to provide
		 * the framework with the basic actors. The proxies/services we want to use in
		 * the model, map some view components to Mediators and to get things started,
		 * add some Sprites to the stage. Only after we drop a Sprite on the stage,
		 * RobotLegs will create the Mediator.
		 *
		 */
		override public function startup():void {
			// Kick everything off one frame later.
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			super.startup();
		}
		
		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			this._moduleEventDispatcher.dispatchEvent( new ExternalShowMainMenuModuleRequest( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED ) );
		}
		
		public function integrateModules( modulesList:Vector.<ModuleContextView> ):void {
			for each ( var nextModule:ModuleContextView in modulesList ) {
				nextModule.setModuleDispatcher( _moduleEventDispatcher );
				nextModule.startup();
				this.contextView.addChild( nextModule );
			}
		}
	
	}
}
