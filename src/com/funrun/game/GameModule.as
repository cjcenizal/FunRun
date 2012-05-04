package com.funrun.game
{
	import com.funrun.game.view.components.Track;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class GameModule extends ModuleContextView
	{
		private var _track:Track;
		
		public function GameModule()
		{
			super();
			context = new GameContext( this );
		}
		
		public function createChildren():void {
			addTrack();
			addUiLayer();
			addPopupsLayer();
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