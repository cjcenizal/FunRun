package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.utils.Center;
	
	import flash.display.DisplayObjectContainer;
	
	public class PopupsView extends AbstractComponent {
		
		private var _popups:Array;
		
		public function PopupsView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		public function init():void {
			_popups = [];
		}
		
		public function add( popup:Popup ):void {
			addChild( popup );
			_popups.push( popup );
			Center.both( popup, stage );
		}
		
		public function remove( popup:Popup ):void {
			for ( var i:int = 0; i < _popups.length; i++ ) {
				if ( _popups[ i ] == popup ) {
					removeChild( popup );
					_popups.splice( i, 1 );
					return;
				}
			}
		}
	}
}
