package com.funrun.game {
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class GameMediator extends ModuleMediator {
		
		[Inject]
		public var view:GameModule;
		
		override public function onRegister():void {
			view.createChildren();
			
			// Listen for both outer-module and inner-module events.
			//moduleCommandMap.mapEvent(LessonNavEvent.PAUSE_LESSON, PauseLessonCommand, LessonNavEvent);
			//eventMap.mapListener(eventDispatcher, LessonEvent.LESSON_PLAY, redispatchToModules);
		}
	}
}
