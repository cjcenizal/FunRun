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
		- Networking problems
			- Ian couldn't move because a resetTimer message was sent. The logc is wonky there.
		- Smack is way too forgiving on a one-block, but only SOMETIMES!
			- Still collision issues:
				- Jumping up into the top front edge of a smack block launched me in the air
				- Jumping into the side of a smack block smacked me instead of blocking me
		- There's definitely a memory leak
			- If I start profiling, I die somehow.  Too much going on initialization wise?
			- Maybe the commands being called over and over are causing it?
			- If I'm dead, there is no mem leak, so it must be caused by GameLoop.
		- To optimize against memory deallocation pauses, we can implement an object pool for segments
		
		BUILDER:
		- Build cool obstacles
		- HTML5 and fun UI: http://www.buildwithchrome.com/static/builder#pos=950513x618389&load=ahFzfmJ1aWxkd2l0aGNocm9tZXIsCxIFQnVpbGQiIXRpbGV4Xzk1MDUxM190aWxleV82MTgzODlfem9vbV8yMAw
		
		TO-DO:
		- New multiplayer process
			- Click join game
				- Float in space with a "ready" button in front of you
				- Wait for 4 people to join and click ready
			- Start game
			- Add "leave lobby" button
			- Exit game boots back to lobby
		- In lieu of offline state, just add option for "single player"
		- Memory pool for BoundingBoxVos
		- Send dash and jump via network so we can have sound fx
		- Camera: tilt during turn, jitter/rumble on rough surfaces, shake on smack
		- Add dash
			- Rechargeable meter
		- Add duck during exploration mode
		- Make points exist in long rows
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
		- Analytics / metrics
			- Chatrooms will let me ask players directly what they think
			- Measure which blocks of obstacles kill players
			- If we give players options (play easy or hard obstacles) we can measure which is more popular.
		
		- Use models and animation
		- Chatting in a 3D room
			- Zoom in if we are standing still, zoom out if we're moving: http://rumpetroll.com/
		- When we're observing, enable mouse movement and scroll wheel for zooming.
			- Also enable burping, honking, and raspberrying the observed player.
			- While you run, enable ghosts so you can see who's watching you.
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			stage.frameRate = Time.FPS;
		}
	}
}
