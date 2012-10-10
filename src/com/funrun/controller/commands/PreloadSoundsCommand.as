package com.funrun.controller.commands
{
	import com.funrun.model.SoundsModel;
	import com.funrun.model.constants.Sounds;
	import com.funrun.services.JsonService;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class PreloadSoundsCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var soundsModel:SoundsModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/audio.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			var obj:Object = new JsonService().readString( data );
			var sounds:Object = obj[ 'sounds' ];
			var folder:String = sounds[ 'folder' ];
			var list:Array = sounds[ 'list' ];
			
			var queue:LoaderMax = new LoaderMax( {
					name: "sounds",
					onProgress: progressHandler,
					onComplete: completeHandler,
					onError: errorHandler
				} );
			
			for ( var i:int = 0; i < list.length; i++ ) {
				var id:String = list[ i ][ 'id' ];
				var files:Array = list[ i ][ 'list' ];
				for ( var j:int = 0; j < files.length; j++ ) {
					var filepath:String = folder + "/" + files[ j ];
					var loader:MP3Loader = new MP3Loader( filepath, { name: id, autoPlay: false } );
					soundsModel.add( id, loader.content as Sound );
					queue.append( loader );
				}
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