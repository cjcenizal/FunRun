package com.funrun.game.view.mediators
{
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.AddObstacleFulfilled;
	
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
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			// Listen for AddObstacleRequest
			eventMap.mapListener( eventDispatcher, AddObstacleFulfilled.ADD_OBSTACLE_FULFILLED, onAddObstacleFulfilled );
			// Dispatch an AddObstacleRequest
			eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
		}
		
		private function onAddObstacleFulfilled( e:AddObstacleFulfilled ):void {
			view.addObstacle( e.obstacle );
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