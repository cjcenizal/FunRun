package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class DistanceView extends AbstractComponent {
		
		private var _distanceLabel:AbstractLabel;
		private var _distanceCountLabel:AbstractLabel;
		
		public function DistanceView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			_distanceLabel = new AbstractLabel( this, 0, 0, "Distance", 12, 0 );
			_distanceCountLabel = new AbstractLabel( this, 0, 0, "0", 24, 0 );
			_distanceLabel.draw();
			_distanceCountLabel.draw();
			_distanceLabel.x = _distanceCountLabel.x = 20;
			_distanceCountLabel.y = stage.stageHeight - _distanceCountLabel.height - 20;
			_distanceLabel.y = _distanceCountLabel.y - _distanceLabel.height;
		}
		
		public function showDistance( distance:String ):void {
			_distanceCountLabel.text = distance;
			_distanceCountLabel.draw();
		}
	}
}
