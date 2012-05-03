package {
	
	import com.funrun.GameContext;
	import com.funrun.view.components.Track;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF( backgroundColor = "#000000", frameRate = "30", quality = "LOW" )]
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class FunRun extends Sprite {
		
		private var _context:GameContext;
		private var _track:Track;
		
		public function FunRun() {
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			_context = new GameContext( this, false );
			_context.startup();
		}
		
		public function createChildren():void {
			setupStage();
			addTrack();
			addUiLayer();
			addPopupsLayer();
		}
		
		private function setupStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function addTrack():void {
			_track = new Track();
			addChild( _track );
		}
		
		private function addUiLayer():void {
			
		}
		
		private function addPopupsLayer():void {
			
		}
	}

}
