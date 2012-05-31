package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;

	public class GameView extends AbstractComponent {
		
		private var _track:TrackView;
		private var _nametags:NametagsView;
		private var _distance:DistanceView;
		private var _countdown:CountdownView;
		private var _quitGameButton:QuitGameView;

		public function GameView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			visible = false;
		}

		public function init():void {
			_track = new TrackView( this );
			_nametags = new NametagsView( this );
			_distance = new DistanceView( this );
			_countdown = new CountdownView( this );
			_quitGameButton = new QuitGameView( this );
		}
	}
}
