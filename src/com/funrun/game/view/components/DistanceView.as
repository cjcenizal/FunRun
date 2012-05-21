package com.funrun.game.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class DistanceView extends AbstractComponent {
		
		private var _distanceLabel:AbstractLabel;
		
		public function DistanceView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			_distanceLabel = new AbstractLabel( this, 0, 0, "Distance", 12, 0 );
			//trace( Math.round( distanceModel.distance * .5 ) * .1 );
		}
	}
}
