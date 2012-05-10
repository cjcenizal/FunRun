package com.funrun.game.view.mediators
{
	import com.funrun.game.controller.events.AddObstacleToSceneRequest;
	import com.funrun.game.controller.events.AddPlayerFulfilled;
	import com.funrun.game.controller.events.AddSceneObjectFulfilled;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.controller.events.RemoveObstacleFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.events.CollisionEvent;
	
	import flash.display.Stage;
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
			stage = view.stage;
			view.init();
			view.debug();
			view.addEventListener( CollisionEvent.COLLISION, onCollision );
			
			eventMap.mapListener( eventDispatcher, AddPlayerFulfilled.ADD_PLAYER_FULFILLED, onAddPlayerFulfilled );
			eventMap.mapListener( eventDispatcher, AddObstacleToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, onAddObstacleToSceneRequested );
			eventMap.mapListener( eventDispatcher, RemoveObstacleFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, onRemoveObstacleFromSceneRequested );
			eventMap.mapListener( eventDispatcher, AddSceneObjectFulfilled.ADD_SCENE_OBJECT_FULFILLED, onAddSceneObjectFulfilled );
			eventMap.mapListener( eventDispatcher, RenderSceneRequest.RENDER_SCENE_REQUESTED, onRenderSceneRequested );
			eventMap.mapListener( eventDispatcher, EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED, onEnablePlayerInputRequested );

			// this probably doesn't belong here, but track needs to exist before the game is built
			eventDispatcher.dispatchEvent( new BuildTimeRequest( BuildTimeRequest.BUILD_TIME_REQUESTED ) );
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
		
		private function onEnablePlayerInputRequested( e:EnablePlayerInputRequest ):void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function onAddPlayerFulfilled( e:AddPlayerFulfilled ):void {
			view.addPlayer( e.player );
		}
		
		private function onAddObstacleToSceneRequested( e:AddObstacleToSceneRequest ):void {
			view.addObstacle( e.obstacle );
		}
		
		private function onRemoveObstacleFromSceneRequested( e:RemoveObstacleFromSceneRequest ):void {
			view.removeObstacle( e.obstacle );
		}
		
		private function onCollision( e:CollisionEvent ):void {
			// collision
		}
		
		private function onAddSceneObjectFulfilled( e:AddSceneObjectFulfilled ):void {
			view.addObject( e.object );
		}
		
		private function onRenderSceneRequested( e:RenderSceneRequest ):void {
			view.render();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					if ( !view.isAirborne ) {
						view.jump();
					}
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