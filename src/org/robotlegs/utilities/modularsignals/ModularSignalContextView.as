/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.utilities.modularsignals
{
	import flash.display.Sprite;
	
	import org.robotlegs.utilities.modular.core.IModuleContextView;
	import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;
	
	public class ModularSignalContextView extends Sprite implements IModuleContextView
	{
		protected var context:ModularSignalContext;
		
		public function ModularSignalContextView()
		{
		}
		
		public function setModuleDispatcher(dispatcher:IModuleEventDispatcher):void
		{
			context.setModuleDispatcher(dispatcher);
		}
		
		public function startup():void
		{
			context.startup();
		}
	}
}