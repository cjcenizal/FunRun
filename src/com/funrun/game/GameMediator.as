package com.funrun.game {
	
	import com.funrun.game.controller.events.StartGameRequest;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class GameMediator extends ModuleMediator {
		
		[Inject]
		public var view:GameModule;
		
		override public function onRegister():void {
			// Listen for both outer-module and inner-module events.
			//moduleCommandMap.mapEvent(LessonNavEvent.PAUSE_LESSON, PauseLessonCommand, LessonNavEvent);
			//eventMap.mapListener(eventDispatcher, LessonEvent.LESSON_PLAY, redispatchToModules);
			eventMap.mapListener( eventDispatcher, StartGameRequest.START_GAME_REQUESTED, onStartGameRequested );
		}
		
		private function onStartGameRequested( e:StartGameRequest ):void {
			view.init();
		}
		
		
	}
}
