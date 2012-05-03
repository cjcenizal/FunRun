package {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import com.funrun.GameContext;
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
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
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
		
		
		private var _context:GameContext;
		
		public function FunRun() {
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			_context = new GameContext( this, false );
			_context.startup();
		}
		
		public function createChildren():void {
			setupStage();
			addUiLayer();
			addPopupsLayer();
		}
		
		private function setupStage():void {
			stage.frameRate = 30;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function addUiLayer():void {
			
		}
		
		private function addPopupsLayer():void {
			
		}
		/*
		private function init():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_obstacles = [];
			_course = new ObstacleCourse();
			addChild( _course );
			_course.init();
		}*/
		
		private function start():void {
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			addObstacle();
		}
		
		private function onEnterFrame( e:Event ):void {
			_course.update();
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				var collides:Boolean = obstacle.collide( _course.player );
				if ( collides ) {
					stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				}
				obstacle.move( -_speed );
			}
			if ( len > 0 ) {
				if ( obstacle.prevZ >= TRIGGER_POS && obstacle.z < TRIGGER_POS ) {
					addObstacle();
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= END_POS ) {
					// Remove item.
					obstacle.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
			for ( var i:int = 0; i < _obstacles.length; i++ ) {
				obstacle = _obstacles[ i ];
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
					if ( mesh ) {
						mesh.position = ( flip ) ? new Vector3D( ( 2 - col ) * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 ) : new Vector3D( col * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 );
						_course.scene.addChild( mesh );
						obstacle.addGeo( mesh );
					}
				}
			}
			_course.scene.addChild( obstacle );
			obstacle.move( START_POS );
			_obstacles.unshift( obstacle );
		}
		
		private var EMPTY_GEO:PlaneGeometry = new PlaneGeometry( 1, 1 );
		private var LEDGE_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 900, 50 );
		private var WALL_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 500, 50 );
		private var BEAM_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 50, 50 );
		
		private function getMesh( geo:String ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case "empty":
					mesh = null;//new Mesh( EMPTY_GEO, _course.activeMaterial );
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
			if ( !stage.hasEventListener( Event.ENTER_FRAME ) ) stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
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
