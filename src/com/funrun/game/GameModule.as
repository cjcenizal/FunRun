package com.funrun.game
{
	import com.funrun.game.view.components.DistanceView;
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.StageQuality;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class GameModule extends ModuleContextView
	{
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		private var _distance:DistanceView;
		
		public function GameModule()
		{
			super();
			context = new GameContext( this );
			visible = false;
		}
		
		public function build():void {
			addTrack();
			addUiLayer();
			addPopupsLayer();
		}
		
		private function addTrack():void {
			_track = new TrackView( this );
		}
		
		private function addUiLayer():void {
			_distance = new DistanceView( this );
		}
		
		private function addPopupsLayer():void {
			
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
				stage.quality = StageQuality.LOW;
			}
		}
		
		public function stopRunning():void {
			this.visible = false;
			_isRunning = false;
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
	}
}