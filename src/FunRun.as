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
		- Search for TO-DOs
		- Cull obstacles based on camera target position, not observed competitor position.
		- Game design
			- Implement cool obstacles
			- Test multiplayer to make sure it still works
			- Performance gets pretty choppy, probably because I'm running the game twice on my system
				- Can we send and receive Booleans as bytes?
			- Test performance on baby laptop
		- Virtual goods visibility
			- Players join game facing backwards and then turn around, so you see them and they see you
				- On join game, check if # players > 0
				- If no other players, start facing forwards
				- Else, start in front of other players, facing them, with interaction disabled
					- Camera is locked to player rotation
				- Rotate player, move them back to their correct starting place, enable interaction
				- Move overall camera position farther back, so we can see more context of other players
			- Portraits of players when see the results of a run
			- Camera shows front during observer mode, look around with mouse
		
		
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
		- Anti-gravity / low-gravity / side-gravity obstacles.
		- Free exploration mode when you're dead, and faster speeds.
		
		
		// "Thank you! Just for playing, you get 50 credits for free!"
		// Refer to Sonic racing game
		// Photonic
		
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
