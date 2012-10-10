package com.funrun.controller.commands
{
	import com.funrun.model.SoundsModel;
	import com.funrun.model.constants.Sounds;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class PreloadCommand extends AsyncCommand
	{
		
		// Models.
		
		[Inject]
		public var soundsModel:SoundsModel;
		
		override public function execute():void
		{
			
			// Set up sounds.
			soundsModel.folder = "audio/";
			soundsModel.add( Sounds.JUMP, "jump.mp3" );
			soundsModel.add( Sounds.POINT, "point1.mp3" );
			soundsModel.add( Sounds.POINT, "point2.mp3" );
			soundsModel.add( Sounds.POINT, "point3.mp3" );
			
			var queue:LoaderMax = new LoaderMax( {
					name: "soundsQueue",
					onProgress: progressHandler,
					onComplete: completeHandler,
					onError: errorHandler
				} );
			
			for ( var i:int = 0; i < soundsModel.count; i++ ) {
				var filepath:String = soundsModel.getAt( i );
				queue.append( new MP3Loader( filepath ) );
			}
			
			queue.load();
			this.dispatchComplete( true );
		}
		
		private function progressHandler( event:LoaderEvent ):void {
		}
			
		private function completeHandler( event:LoaderEvent ):void {
		}
			
		private function errorHandler( event:LoaderEvent ):void {
		}
	}
}