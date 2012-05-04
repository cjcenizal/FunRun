package com.funrun.modulemanager {
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class ModuleManager extends ModuleContextView {
		
		private var moduleManagerContext:ModuleManagerContext;
		
		public function ModuleManager():void {
			moduleManagerContext = new ModuleManagerContext( this );
			context = moduleManagerContext;
			init();
		}
		
		private function init():void {
		
		}
		
		public function integrateModules( modulesList:Vector.<ModuleContextView> ):void {
			moduleManagerContext.integrateModules( modulesList );
		}
	
	}
}
