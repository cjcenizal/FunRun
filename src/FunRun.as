package {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import com.funrun.model.GeosModel;
	import com.funrun.model.ObstacleVO;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.view.Obstacle;
	import com.funrun.view.ObstacleCourse;
	import com.funrun.view.ObstacleFactory;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	
	[SWF( backgroundColor = "#000000", frameRate = "30", quality = "LOW" )]
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class FunRun extends Sprite {
		
		// Constants.
		private const START_POS:Number = 5000;
		private const GEO_SIZE:Number = 50 * 5;
		private const TRIGGER_POS:Number = START_POS - 1200;
		private const END_POS:Number = -600;
		private const MESH_WIDTH:Number = 300;
		private var _speed:Number = 60;
		private var _obstacles:Array;
		
		private var _geosModel:GeosModel = new GeosModel();
		private var _obstaclesModel:ObstaclesModel = new ObstaclesModel();
		private var _factory:ObstacleFactory = new ObstacleFactory();
		private var _course:ObstacleCourse;
		
		public function FunRun() {
			init();
			start();
		}
		
		private function init():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_obstacles = [];
			_course = new ObstacleCourse();
			addChild( _course );
			_course.init();
		}
		
		private function start():void {
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			addObstacle();
		}
		
		private function onEnterFrame( e:Event ):void {
			var item:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			
			for ( var i:int = len - 1; i >= 0; i-- ) {
				item = _obstacles[ i ];
				item.move( -_speed );
			}
			if ( len > 0 ) {
				if ( item.prevZ >= TRIGGER_POS && item.z < TRIGGER_POS ) {
					addObstacle();
				}
				var item:Obstacle = _obstacles[ len - 1 ];
				if ( item.z <= END_POS ) {
					// Remove item.
					item.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
			for ( var i:int = 0; i < _obstacles.length; i++ ) {
				item = _obstacles[ i ];
			}
		}
		
		private function addObstacle():void {
			// New obstacles go in front.
			var data:ObstacleVO = _obstaclesModel.getRandomObstacle();
			var obstacle:Obstacle = new Obstacle( data.id );
			var mesh:Mesh;
			var flip:Boolean = Math.random() < .5;
			for ( var col:int = 0; col < 3; col++ ) {
				for ( var row:int = 0; row < 5; row++ ) {
					mesh = getMesh( data.geos[ row ][ col ] );
					mesh.position = ( flip ) ? new Vector3D( ( 2 - col ) * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 ) : new Vector3D( col * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 );
					_course.scene.addChild( mesh );
					obstacle.addGeo( mesh );
				}
			}
			_course.scene.addChild( obstacle );
			obstacle.move( START_POS );
			_obstacles.unshift( obstacle );
		}
		
		private var EMPTY_GEO:PlaneGeometry = new PlaneGeometry( 1, 1 );
		private var LEDGE_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 900, 50 );
		private var WALL_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 100, 50 );
		private var BEAM_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 50, 50 );
		
		private function getMesh( geo:String ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case "empty":
					mesh = new Mesh( EMPTY_GEO, _course.activeMaterial );
					break;
				
				case "ledge":
					mesh = new Mesh( LEDGE_GEO, _course.activeMaterial );
					break;
				
				case "wall":
					mesh = new Mesh( WALL_GEO, _course.activeMaterial );
					break;
				
				case "beam":
					mesh = new Mesh( BEAM_GEO, _course.activeMaterial );
					break;
			}
			return mesh;
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					_course.jump();
					break;
				case Keyboard.LEFT:
					_course.startMovingLeft();
					break;
				case Keyboard.RIGHT:
					_course.startMovingRight();
					break;
				case Keyboard.DOWN:
					_course.startDucking();
					break;
			}	
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					_course.stopJumping();
					break;
				case Keyboard.LEFT:
					_course.stopMovingLeft();
					break;
				case Keyboard.RIGHT:
					_course.stopMovingRight();
					break;
				case Keyboard.DOWN:
					_course.stopDucking();
					break;
			}
			
		}
		
	}

}
