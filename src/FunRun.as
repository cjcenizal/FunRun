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
		BUGS:
		- Smack is way too forgiving on a one-block, but only SOMETIMES!
		- There's definitely a memory leak
		- To optimize against memory deallocation pauses, we can implement an object pool for segments
		- Points stop appearing
		
		BUILDER:
		- Build cool obstacles
		- HTML5 and fun UI: http://www.buildwithchrome.com/static/builder#pos=950513x618389&load=ahFzfmJ1aWxkd2l0aGNocm9tZXIsCxIFQnVpbGQiIXRpbGV4Xzk1MDUxM190aWxleV82MTgzODlfem9vbV8yMAw
		
		TO-DO:
		- Search for TO-DOs
		- Game design
			- Collect points
				- Rewards for getting 1st, 2nd, 3rd place are fun and silly badges, and a small points bonus.
				- Make points persistent on the server
				- Be smarter about selecting how many points are visible
			- Design and implement glue screens
				- Home
				- Results screen showing personal bests, rewards
			- Sound fx and music
			- Design a decent UI
			- Add social sharing
			- Test multiplayer to make sure it still works
			- Performance gets pretty choppy, probably because I'm running the game twice on my system
				- Can we send and receive Booleans as bytes?
			- Chat
			- Metrics?
			- Basic animation, music, and sound?
			- Test MVP
		
			- Make ball look like it's rolling
				- Add some squash and stretch to jumping and turning
		
			- Build stubbed store functionality
			- Observer loop:
				- Display their attire in the UI
				- Allow point and click to navigate through competitors
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
		- Nice UI with comfy pressable buttons.
		- Full-screen, or fluid 100% window size.
		- Anti-gravity / low-gravity / side-gravity obstacles.
		- Free exploration mode when you're dead, and faster speeds.
		- As you collect points make them fly into your points counter
		
		
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
