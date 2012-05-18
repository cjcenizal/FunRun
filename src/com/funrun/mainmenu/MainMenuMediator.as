package com.funrun.mainmenu {
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class MainMenuMediator extends ModuleMediator {
		
		[Inject]
		public var view:MainMenuModule;
		
		override public function onRegister():void {
			view.build();
			// Listen for both outer-module and inner-module events.
			// EXAMPLE: moduleCommandMap.mapEvent(LessonNavEvent.PAUSE_LESSON, PauseLessonCommand, LessonNavEvent);
			// EXAMPLE: eventMap.mapListener( eventDispatcher, BuildGameRequest.START_GAME_REQUESTED, onStartGameRequested );
		}
		
	}
}
