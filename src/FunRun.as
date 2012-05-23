package {
	
	import com.funrun.game.GameModule;
	import com.funrun.mainmenu.MainMenuModule;
	import com.funrun.modulemanager.ModuleManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	import org.robotlegs.utilities.modularsignals.ModularSignalContextView;
	
	[SWF( backgroundColor = "#000000", frameRate = "30", width="800" , height="600" )]
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class FunRun extends Sprite {
		
		public function FunRun() {
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			setupStage();
			
			var moduleManager:ModuleManager = new ModuleManager();
			addChild(moduleManager);
			
			// Store modules. Position or configure them as required.
			var moduleVector:Vector.<ModularSignalContextView> = new Vector.<ModularSignalContextView>();
			
			// Add main menu.
			var mainMenuModule:MainMenuModule = new MainMenuModule();
			moduleVector[ moduleVector.length ] = mainMenuModule;
			
			// Add game.
			var gameModule:GameModule = new GameModule();
			moduleVector[ moduleVector.length ] = gameModule;
			
			// Should game UI go here instead of in the game package?  How about game popups, like a results screen?
			
			// Add editor.
			
			moduleManager.integrateModules( moduleVector );
			
			ExternalInterface.call( "onSwfLoaded" );
		}
		
		private function setupStage():void {
			stage.color = 0xffffff;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
		}
	}
}
