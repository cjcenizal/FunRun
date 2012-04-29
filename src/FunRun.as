package {
	
	import com.funrun.model.GeosModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.view.Obstacle;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF( backgroundColor = "#000000", frameRate = "30", quality = "LOW" )]
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class FunRun extends Sprite {
		
		// Constants.
		private const START_POS:Number = 2000;
		private const GEO_SIZE:Number = 100;
		private var _speed:Number = 2;
		private var _obstacles:Array;
		
		private var _geosModel:GeosModel = new GeosModel();
		private var _obstaclesModel:ObstaclesModel = new ObstaclesModel();
		
		public function FunRun() {
			init();
			start();
		}
		
		private function init():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_obstacles = [];
		}
		
		private function start():void {
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void {
			var item:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i++ ) {
				item.y -= _speed;
			}
			if ( len > 0 ) {
				if ( item.y > START_POS - GEO_SIZE ) {
					// New obstacles go in front.
					_obstacles.push(  );
				}
				var item:Obstacle = _obstacles[ len - 1 ];
				if ( item.y <= 0 ) {
					// Remove item.
					item.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
			for ( var i:int = 0; i < _obstacles.length; i++ ) {
				item = _obstacles[ i ];
				trace(i + " " + item.id + " " + item.y);
			}
		}
		
	}

}
