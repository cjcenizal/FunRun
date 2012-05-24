package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;

	public class GameView extends AbstractComponent {

		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		private var _distance:DistanceView;
		private var _countdown:CountdownView;

		public function GameView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
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
