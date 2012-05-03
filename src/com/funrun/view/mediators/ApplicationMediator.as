package com.funrun.view.mediators
{
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:FunRun;

		override public function onRegister():void {
			view.createChildren();
		}
	}
}
