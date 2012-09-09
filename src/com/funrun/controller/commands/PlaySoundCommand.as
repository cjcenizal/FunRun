package com.funrun.controller.commands
{
	import com.funrun.model.SoundsModel;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlaySoundCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var id:String;
		
		// Models.
		
		[Inject]
		public var soundsModel:SoundsModel;
		
		override public function execute():void
		{
			var filepath:String = soundsModel.getFilepath( id );
			var sound:Sound = new Sound( new URLRequest( filepath ) );
			sound.play();
		}
	}
}