package com.funrun.game
{
	import com.funrun.game.view.components.TrackView;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class GameModule extends ModuleContextView
	{
		private var _track:TrackView;
		
		public function GameModule()
		{
			super();
			context = new GameContext( this );
		}
		
		public function init():void {
			addTrack();
			addUiLayer();
			addPopupsLayer();
		}
		
		
		private function addTrack():void {
			_track = new TrackView();
			addChild( _track );
		}
		
		private function addUiLayer():void {
			
		}
		
		private function addPopupsLayer():void {
			
		}
	}
}