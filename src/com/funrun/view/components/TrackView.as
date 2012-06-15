package com.funrun.view.components {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class TrackView extends AbstractComponent {
		
		private var _view:View3D;
		
		/**
		 * Constructor
		 */
		public function TrackView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		/**
		 * Initialize our view, scene, and camera.
		 */
		public function init():void {
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug():void {
			// Add stats.
			var awayStats:AwayStats = new AwayStats( _view );
			addChild( awayStats );
		}
		
		public function set view3D( view:View3D ):void {
			if ( _view ) {
				removeChild( _view );
				_view = null;
			}
			_view = view;
			addChild( _view );
		}
	}
}
