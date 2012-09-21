package com.funrun.view.mediators
{
	import com.cenizal.utils.Console;
	
	import flash.events.KeyboardEvent;
	
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
			/*this.contextView.stage.addEventListener( Event.DEACTIVATE, onDeactivate );*/
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
	}
}