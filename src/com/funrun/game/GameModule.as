package com.funrun.game
{
	import com.funrun.game.view.components.TrackView;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class GameModule extends ModuleContextView
	{
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		
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
			_track = new TrackView();
			addChild( _track );
		}
		
		private function addUiLayer():void {
			
		}
		
		private function addPopupsLayer():void {
			
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
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