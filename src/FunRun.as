package {
	
	import com.funrun.game.GameModule;
	import com.funrun.modulemanager.ModuleManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.events.Event;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	[SWF( backgroundColor = "#000000", frameRate = "30", quality = "LOW" )]
	
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
			
			var gameModule:GameModule = new GameModule();
			var moduleVector:Vector.<ModuleContextView> = new Vector.<ModuleContextView>();
			moduleVector[ moduleVector.length ] = gameModule;
			
			// Position or configure modules as required here.
			
			moduleManager.integrateModules( moduleVector );
		}
		
		private function setupStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
		}
	}

}
