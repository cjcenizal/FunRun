package com.funrun.game {
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class GameMediator extends ModuleMediator {
		
		[Inject]
		public var view:GameModule;
		
		override public function onRegister():void {
			view.build();
			// Listen for both outer-module and inner-module events.
			// EXAMPLE: moduleCommandMap.mapEvent(LessonNavEvent.PAUSE_LESSON, PauseLessonCommand, LessonNavEvent);
			// EXAMPLE: eventMap.mapListener( eventDispatcher, BuildGameRequest.START_GAME_REQUESTED, onStartGameRequested );
			//moduleCommandMap.mapEvent(
		}
		
	}
}
