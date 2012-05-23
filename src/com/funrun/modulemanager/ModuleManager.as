package com.funrun.modulemanager {
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	import org.robotlegs.utilities.modularsignals.ModularSignalContextView;
	
	public class ModuleManager extends ModularSignalContextView {
		
		private var moduleManagerContext:ModuleManagerContext;
		
		public function ModuleManager():void {
			moduleManagerContext = new ModuleManagerContext( this );
			context = moduleManagerContext;
		}
		
		public function integrateModules( modulesList:Vector.<ModuleContextView> ):void {
			moduleManagerContext.integrateModules( modulesList );
		}
	
	}
}
