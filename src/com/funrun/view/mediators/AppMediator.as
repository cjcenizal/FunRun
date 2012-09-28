package com.funrun.view.mediators
{
	import com.cenizal.utils.Console;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:FunRun;
		
		[Inject]
		public var console:Console;
		
		override public function onRegister():void {
			view.createChildren();
			view.addChild( console );
			
			this.contextView.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			this.contextView.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			this.contextView.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			this.contextView.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			this.contextView.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			this.contextView.stage.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			/*this.contextView.stage.addEventListener( Event.DEACTIVATE, onDeactivate );*/
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onMouseDown( e:MouseEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onMouseUp( e:MouseEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onMouseMove( e:MouseEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onMouseWheel( e:MouseEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
	}
}