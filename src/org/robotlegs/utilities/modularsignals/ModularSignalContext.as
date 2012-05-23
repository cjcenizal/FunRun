/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.utilities.modularsignals
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.mvcs.SignalContext;
	import org.robotlegs.utilities.modular.base.ModuleCommandMap;
	import org.robotlegs.utilities.modular.core.IModuleCommandMap;
	import org.robotlegs.utilities.modular.core.IModuleContext;
	import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;
	
	public class ModularSignalContext extends SignalContext implements IModuleContext
	{
		protected var _isModuleDispatcherSet:Boolean;
		
		public function ModularSignalContext(contextView:DisplayObjectContainer = null)
		{
			// autostartup doesn't make sense in this set up because you need to run setModuleDispatcher before startup();
			super(contextView, false);
		}
		
		override public function startup():void
		{
			if (!_isModuleDispatcherSet)
			{
				trace("DIAGNOSTIC HELPER: You need to set up the module dispatcher before you can run startup. If your app bails now... you'll know why.")
			}
			super.startup();
		}
		
		public function setModuleDispatcher(dispatcher:IModuleEventDispatcher):void
		{
			injector.mapValue(IModuleEventDispatcher, dispatcher);
			injector.mapValue(IModuleCommandMap, new ModuleCommandMap(dispatcher, injector, reflector));
			
			_isModuleDispatcherSet = true;
		}
	}
}