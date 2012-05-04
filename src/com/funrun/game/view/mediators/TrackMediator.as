package com.funrun.game.view.mediators
{
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.AddPlayerFulfilled;
	import com.funrun.game.controller.events.AddSceneObjectFulfilled;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.StartGameFulfilled;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:TrackView;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			view.init();
			view.debug();
			stage = view.stage;
			
			eventMap.mapListener( eventDispatcher, AddPlayerFulfilled.ADD_PLAYER_FULFILLED, onAddPlayerFulfilled );
			eventMap.mapListener( eventDispatcher, AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, onAddObstacleFulfilled );
			eventMap.mapListener( eventDispatcher, AddSceneObjectFulfilled.ADD_SCENE_OBJECT_FULFILLED, onAddSceneObjectFulfilled );
			eventMap.mapListener( eventDispatcher, StartGameFulfilled.START_GAME_FULFILLED, onStartGameFulfilled );
			
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) ); // this probably doesn't belong here, but track needs to exist before the game is built
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
		
		private function onStartGameFulfilled( e:StartGameFulfilled ):void {
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			// Request first obstacle.
			eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
		}
		
		private function onAddPlayerFulfilled( e:AddPlayerFulfilled ):void {
			view.addPlayer( e.player );
		}
		
		private function onAddObstacleFulfilled( e:AddObstacleFulfilled ):void {
			view.addObstacle( e.obstacle );
		}
		
		private function onAddSceneObjectFulfilled( e:AddSceneObjectFulfilled ):void {
			view.addObject( e.object );
		}
		
		private function onEnterFrame( e:Event ):void {
			view.update();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					view.jump();
					break;
				case Keyboard.LEFT:
					view.startMovingLeft();
					break;
				case Keyboard.RIGHT:
					view.startMovingRight();
					break;
				case Keyboard.DOWN:
					view.startDucking();
					break;
			}	
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			if ( !stage.hasEventListener( Event.ENTER_FRAME ) ) {
				stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					view.stopJumping();
					break;
				case Keyboard.LEFT:
					view.stopMovingLeft();
					break;
				case Keyboard.RIGHT:
					view.stopMovingRight();
					break;
				case Keyboard.DOWN:
					view.stopDucking();
					break;
			}
			
		}
	}
}