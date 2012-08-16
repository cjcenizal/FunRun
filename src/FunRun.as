package {
	
	import com.funrun.MainContext;
	import com.funrun.model.constants.Time;
	import com.funrun.view.components.MainView;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	[SWF( backgroundColor = "#000000", width="800" , height="600" )]
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class FunRun extends Sprite {
		
		
		/*
		TO-DO:
		- Fix bug where I am able to jump through stairs
			- Especially in ducking state
			- And hitting the side of some obstacles triggers a smack instead of hit.
		- Use models and animation (players are food? Food Run?)
		- Make sure hitboxes are SMALLER than the model
		- Economy
			- http://conversionxl.com/pricing-experiments-you-might-not-know-but-can-learn-from/
			- http://news.ycombinator.com/item?id=4370904
		- Collectibles (food?)
		- Nice UI with comfy pressable buttons.
		- Foody red/yellow/white color scheme
		- Sound fx
		- Music
		- Full-screen, or fluid 100% window size.
		*/
		
		
		private var _mainContext:MainContext;
		private var _mainView:MainView;
		
		public function FunRun() {
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			setupStage();
			_mainContext = new MainContext( this, false );
			_mainContext.startup();
			ExternalInterface.call( "onSwfLoaded" );
		}
		
		public function createChildren():void {
			_mainView = new MainView( this );
		}
		
		private function setupStage():void {
			stage.color = 0xffffff;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			stage.frameRate = Time.FPS;
		}
	}
}
