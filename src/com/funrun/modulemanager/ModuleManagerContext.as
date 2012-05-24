package com.funrun.modulemanager {
	
	import com.funrun.game.controller.commands.BuildWhitelistCommand;
	import com.funrun.game.controller.commands.InitAppCommand;
	import com.funrun.game.controller.commands.LoadConfigurationCommand;
	import com.funrun.game.controller.commands.LoginCommand;
	import com.funrun.game.controller.commands.LoginFailedCommand;
	import com.funrun.game.controller.commands.LoginFulfilledCommand;
	import com.funrun.game.controller.commands.ShowMainMenuCommand;
	import com.funrun.game.controller.commands.ToggleMainMenuCommand;
	import com.funrun.game.controller.commands.WhitelistFailedCommand;
	import com.funrun.game.controller.signals.BuildWhitelistRequest;
	import com.funrun.game.controller.signals.LoadConfigurationRequest;
	import com.funrun.game.controller.signals.LoginFailed;
	import com.funrun.game.controller.signals.LoginFulfilled;
	import com.funrun.game.controller.signals.LoginRequest;
	import com.funrun.game.controller.signals.ShowMainModuleRequest;
	import com.funrun.game.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.game.controller.signals.WhitelistFailed;
	import com.funrun.game.model.ConfigurationModel;
	import com.funrun.game.model.UserModel;
	import com.funrun.game.services.IWhitelistService;
	import com.funrun.game.services.PlayerioFacebookLoginService;
	import com.funrun.game.services.WhitelistService;
	
	import flash.events.Event;
	
	import org.robotlegs.utilities.modular.base.ModuleEventDispatcher;
	import org.robotlegs.utilities.modularsignals.ModularSignalContext;
	import org.robotlegs.utilities.modularsignals.ModularSignalContextView;
	
	public class ModuleManagerContext extends ModularSignalContext {
		
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
		
		public function ModuleManagerContext( contextView:ModularSignalContextView ) {
			super( contextView );
			
			var moduleEventDispatcher:ModuleEventDispatcher = new ModuleEventDispatcher();
			setModuleDispatcher( moduleEventDispatcher );
			_moduleEventDispatcher = moduleEventDispatcher;
			
			startup();
		}
		
		public function integrateModules( modulesList:Vector.<ModularSignalContextView> ):void {
			for each ( var nextModule:ModularSignalContextView in modulesList ) {
				nextModule.setModuleDispatcher( _moduleEventDispatcher );
				nextModule.startup();
				this.contextView.addChild( nextModule );
			}
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
			// Map signals.
			injector.mapSingleton( UpdateLoginStatusRequest );
			signalCommandMap.mapSignalClass( BuildWhitelistRequest,					BuildWhitelistCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( LoginRequest,							LoginCommand );
			signalCommandMap.mapSignalClass( LoginFailed,							LoginFailedCommand );
			signalCommandMap.mapSignalClass( LoginFulfilled,						LoginFulfilledCommand );
			signalCommandMap.mapSignalClass( WhitelistFailed,						WhitelistFailedCommand );
			signalCommandMap.mapSignalClass( ShowMainModuleRequest, 				ShowMainMenuCommand );
			signalCommandMap.mapSignalClass( ToggleMainMenuOptionsRequest, 			ToggleMainMenuCommand );
			
			// Map models.
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( UserModel );
			
			// Map services.
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingletonOf( IWhitelistService, WhitelistService ); // TO-DO: Use a variable to toggle between open and regular.
			
			// Kick everything off one frame later.
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			super.startup();
		}
		
		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			commandMap.execute( InitAppCommand );
		}
	}
}
