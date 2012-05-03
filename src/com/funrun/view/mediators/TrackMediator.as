package com.funrun.view.mediators
{
	import com.funrun.view.components.Track;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:Track;
		
		override public function onRegister():void {
			view.init();
		}
	}
}