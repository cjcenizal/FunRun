package com.funrun.game.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class DistanceView extends AbstractComponent {
		
		public function DistanceView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			//trace( Math.round( distanceModel.distance * .5 ) * .1 );
		}
	}
}
