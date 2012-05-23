package com.funrun.game {

	import com.funrun.game.view.components.CountdownView;
	import com.funrun.game.view.components.DistanceView;
	import com.funrun.game.view.components.TrackView;
	
	import org.robotlegs.utilities.modularsignals.ModularSignalContextView;

	public class GameModule extends ModularSignalContextView {
		
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		private var _distance:DistanceView;
		private var _countdown:CountdownView;

		public function GameModule() {
			super();
			context = new GameContext( this );
			visible = false;
		}

		public function build():void {
			_track = new TrackView( this );
			_distance = new DistanceView( this );
			_countdown = new CountdownView( this );
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
