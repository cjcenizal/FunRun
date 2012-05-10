package com.funrun.game.view.mediators
{
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
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
			
			eventMap.mapListener( eventDispatcher, AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, onAddObjectToSceneRequested );
			eventMap.mapListener( eventDispatcher, RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, onRemoveObjectFromSceneRequested );
			eventMap.mapListener( eventDispatcher, RenderSceneRequest.RENDER_SCENE_REQUESTED, onRenderSceneRequested );
			eventMap.mapListener( eventDispatcher, EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED, onEnablePlayerInputRequested );

			// this probably doesn't belong here, but track needs to exist before the game is built
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
		
		private function onEnablePlayerInputRequested( e:EnablePlayerInputRequest ):void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function onAddObjectToSceneRequested( e:AddObjectToSceneRequest ):void {
			view.addToScene( e.object );
		}
		
		private function onRemoveObjectFromSceneRequested( e:RemoveObjectFromSceneRequest ):void {
			view.removeFromScene( e.object );
		}
		
		private function onCollision( e:CollisionEvent ):void {
			// collision
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