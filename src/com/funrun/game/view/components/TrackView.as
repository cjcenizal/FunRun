package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.SubGeometry;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.extrusions.DelaunayMesh;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.materials.SegmentMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.utils.WireframeMapGenerator;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.primitives.WireframeGrid;
	import away3d.textures.Texture2DBase;
	import away3d.tools.commands.Merge;
	import away3d.tools.helpers.FaceHelper;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.model.Constants;
	import com.funrun.game.view.events.CollisionEvent;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class TrackView extends Sprite {
		
		// Engine vars.
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		
		// Obstacle management (perhaps store this in the model?).
		private var _obstacles:Array;
		
		// Player geometry (will be stored in the model?).
		private var _player:Mesh;
		
		// Player state (store in model?).
		private var _forwardVelocity:Number = Constants.MAX_PLAYER_FORWARD_VELOCITY; // This may vary over time as you get slowed.
		private var _jumpVelocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		private var _isAirborne:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function TrackView() {
			_obstacles = [];
		}
		
		/**
		 * Global initialise function
		 */
		public function init():void {
			_view = new View3D();
			_view.antiAlias = 2; // 2, 4, or 16
			_view.width = 800;
			_view.height = 600;
			_view.backgroundColor = 0x111111;
			addChild( _view );
			
			_scene = _view.scene; // Store local refs.
			_camera = _view.camera;
			_camera.y = Constants.CAM_Y;
			_camera.z = Constants.CAM_Z;
			_camera.rotationX = Constants.CAM_TILT;
			_camera.lens = new PerspectiveLens( Constants.CAM_FOV );
			_camera.lens.far = Constants.CAM_FRUSTUM_DISTANCE;
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug():void {
			// Add stats.
			var awayStats:AwayStats = new AwayStats( _view );
			addChild( awayStats );
			// Add grid.
			var grid:WireframeGrid = new WireframeGrid( Constants.TRACK_WIDTH / Constants.BLOCK_SIZE, Constants.TRACK_WIDTH, 2, 0xFFFFFF, WireframeGrid.PLANE_XZ );
			var gridScale:Number = 4;
			grid.scaleZ = gridScale;
			grid.z = Constants.TRACK_WIDTH * gridScale * .5 - 300;
			_scene.addChild( grid );
			grid.y = 1;
		}
		
		/**
		 * Updating.
		 */
		public function update():void {
			updateObstacles();
			updateFloor();
			updatePlayer();
			updateCamera();
			_view.render();
		}
		
		private function updateCamera():void {
			_camera.x = _player.x;
			var followFactor:Number = ( Constants.CAM_Y + _player.y < _camera.y ) ? .6 : .2;
			_camera.y += ( ( Constants.CAM_Y + _player.y ) - _camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		private function updateObstacles():void {
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				obstacle.move( -_forwardVelocity );
			}
			// Check last obstacle for removal and addition of new obstacle.
			if ( len > 0 ) {
				if ( obstacle.prevZ >= Constants.ADD_OBSTACLE_DEPTH && obstacle.z < Constants.ADD_OBSTACLE_DEPTH ) {
		//			dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= Constants.REMOVE_OBSTACLE_DEPTH ) {
					// Remove item.
					obstacle.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
		}
		
		private function updatePlayer():void {
			_jumpVelocity += Constants.PLAYER_JUMP_GRAVITY;
			_player.y += _jumpVelocity;
			_player.x += _lateralVelocity;
			if ( _player.y <= 25 ) { // Temp hack for landing on ground, fix later
				_player.y = 25; // 25 is half the player FPO object's height
				_jumpVelocity = 0;
			}
			_isAirborne = ( Math.abs( _player.y - 25 ) > 1 );
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				var collides:Boolean = obstacle.collide( _player );
				if ( collides ) {
					dispatchEvent( new CollisionEvent( CollisionEvent.COLLISION ) );
				}
			}
		}
		
		private var _floorPanels:Array = [];
		private var _floorMesh:Mesh;
		var floorGeo:PlaneGeometry = new PlaneGeometry( Constants.BLOCK_SIZE, Constants.BLOCK_SIZE );
		var material:ColorMaterial = new ColorMaterial( 0xffffff );
		private function updateFloor():void {
			
			// The simplest fucking way to do this is to add panels between each obstacle.
			
			
			
			
			
			/*
			// Add a delaunay mesh and delete faces.
			var vectors:Vector.<Vector3D> = new Vector.<Vector3D>();
			for(var i:uint = 0; i< 100; ++i){
				vectors[i] = new Vector3D( Math.random() * Constants.TRACK_WIDTH, 0, Math.random() * Constants.TRACK_LENGTH );
			}
			
			var delaunayMesh:DelaunayMesh = new DelaunayMesh( null, vectors, DelaunayMesh.PLANE_XZ, false, false, true );
			delaunayMesh.material = new ColorMaterial( 0xffffff );
			
			trace( ( delaunayMesh.geometry.subGeometries[ 0 ] as SubGeometry ).indexData.length );
			_scene.addChild(delaunayMesh);
			FaceHelper.removeFace( delaunayMesh, 0, 0 );
			*/
			
			
			// Add a bunch of meshes and merge them.
			//for ( var i:int = 0; i < _floorPanels.length; i++ ) {
			//	_scene.removeChild( _floorPanels[ i ] as Mesh );
			//}
			//_floorPanels = [];
			/*
			if ( _floorMesh ) {
				_scene.removeChild( _floorMesh );
			}
			
			var dest:Mesh;
			var src:Vector.<Mesh> = new Vector.<Mesh>;
			for ( var x:int = 0; x < Constants.TRACK_WIDTH; x += Constants.BLOCK_SIZE ) {
				for ( var z:int = 0; z < Constants.TRACK_LENGTH; z += Constants.BLOCK_SIZE ) {
					var block:Mesh = new Mesh( floorGeo.clone(), material );
					block.x = x;
					block.z = z;
					if ( !dest ) {
						dest = block;
					} else {
						src.push( block );
					}
				}
			}	
			if ( src.length > 0 ) {
				var command:Merge = new Merge( false, true );
				_floorMesh = command.applyToMeshes( dest, src )
			} else if ( dest ) {
				_floorMesh = dest;
			}
			_scene.addChild( _floorMesh );
			*/
			
			/*
			// Automatically scale panels to fit between obstacles.
			var xAdjust:Number = Constants.TRACK_WIDTH * .5 - Constants.BLOCK_SIZE * .5;
			var zAdjust:Number = Constants.TRACK_LENGTH * .5 - 300;
			var material:ColorMaterial = new ColorMaterial( 0xffffff );
			var geo:SubGeometry;
			var panel:Mesh;
			var currZ:Number;
			var count:int = 0;
			// For each column.
			for ( var x:int = 0; x < Constants.BLOCK_SIZE; x += Constants.BLOCK_SIZE ) { // TEMPORARY! Turn back to Constants.TRACK_WIDTH
				currZ = Constants.TRACK_LENGTH;
				// For entire length of column.
				while ( currZ > 0 ) {
					// Get geo in column by looking through all obstacles (can be optimized with column sorting).
					for ( var i:int = 0; i < _obstacles.length; i++ ) {
						var obstacle:Obstacle = _obstacles[ i ];
						// Get each geo in obstacle, check to see if it's in column.
						for ( var j:int = 0; j < obstacle.numGeos; j++ ) {
							var block:Mesh = obstacle.getGeoAt( j );
							var pos:Vector3D = block.position.add( obstacle.position );
							if ( getNormalizedBlockX( pos.x ) == x ) {
								// This block is in our column, so let's place a panel leading up to it.
								// First see if we've even moved at all.
								if ( getNormalizedBlockZ( pos.z ) < currZ ) {
									// Get a panel and place it, and update currZ.
									if ( count < _floorPanels.length - 1 ) {
										// Use existing panel if possible.
										trace("use panel " + count);
										panel = _floorPanels[ count ];
										panel.visible = true;
									} else {
										// Add new one if none are available.
										panel = new Mesh( new PlaneGeometry( Constants.BLOCK_SIZE, Constants.TRACK_LENGTH ), material );
										_floorPanels.push( panel );
										_scene.addChild( panel );
									}
									panel.visible = false;
									// Adjust position and size.
									geo = panel.geometry.subGeometries[ 0 ];
									var vertexData:Vector.<Number> = geo.vertexData.concat();
									trace("currZ " + currZ);
						//			trace("a: " + vertexData);
									// 2-5 must be less than 8-11. Higher numbers are near the end of the track.
								//	vertexData[ 2 ] = vertexData[ 5 ] = ( Constants.TRACK_LENGTH * .5 - getNormalizedBlockZ( pos.z ) ) * -1;
								//	vertexData[ 8 ] = vertexData[ 11 ] = ( currZ * .5 );
						//			trace("b: " + vertexData);
									panel.geometry.subGeometries[ 0 ].updateVertexData( vertexData );
									panel.position = new Vector3D( x - xAdjust, 0, zAdjust );
									count++;
									currZ = getNormalizedBlockZ( pos.z ) - Constants.BLOCK_SIZE;
									trace("end currZ: " + currZ);
								}
							}
						}
					}
					
					if ( currZ > 0 ) {
						trace("do extra " + currZ);
						// Get a panel and place it, and update currZ.
						if ( count < _floorPanels.length - 1 ) {
							// Use existing panel if possible.
							trace("    use panel " + count);
							panel = _floorPanels[ count ];
							panel.visible = true;
						} else {
							// Add new one if none are available.
							panel = new Mesh( new PlaneGeometry( Constants.BLOCK_SIZE, Constants.TRACK_LENGTH ), material );
							_floorPanels.push( panel );
							_scene.addChild( panel );
						}
						// Adjust position and size.
						geo = panel.geometry.subGeometries[ 0 ];
						var vertexData:Vector.<Number> = geo.vertexData.concat();
						trace("    c: " + vertexData);
						// 2-5 must be less than 8-11. Higher numbers are near the end of the track.
						vertexData[ 2 ] = vertexData[ 5 ] = -2500;//Constants.TRACK_LENGTH * -.5;
						vertexData[ 8 ] = vertexData[ 11 ] = 1700;//currZ * .5;//( Constants.TRACK_LENGTH * .5 - currZ );
						trace("    d: " + vertexData);
						panel.geometry.subGeometries[ 0 ].updateVertexData( vertexData );
						panel.position = new Vector3D( x - xAdjust, 0, zAdjust );
						currZ = 0;
					}
				}
			}
			// Turn off remaining panels.
			for ( var i:int = count; i < _floorPanels.length; i++ ) {
				( _floorPanels[ count ] as Mesh ).visible = false;
			}
			*/
		}
		
		/**
		 * Adding obstacles to the scene.
		 */
		public function addObstacle( obstacle:Obstacle ):void {
			// New obstacles go in front.
			_obstacles.unshift( obstacle );
			_scene.addChild( obstacle );
			obstacle.move( Constants.TRACK_LENGTH );
		}
		
		private function getNormalizedBlockX( x:Number ):int {
			return x - Constants.BLOCK_SIZE * .5 + Constants.TRACK_WIDTH * .5;
		}
		
		private function getNormalizedBlockZ( z:Number ):int {
			return z + Constants.BLOCK_SIZE * 3.5;// + Constants.BLOCK_SIZE * .5;
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addObject( child:ObjectContainer3D ):void {
			_scene.addChild( child );
		}
		
		/**
		 * Adding player to the scene.
		 */
		public function addPlayer( player:Mesh ):void {
			_player = player;
			_scene.addChild( player );
		}
		
		/**
		 * Control the player.
		 */
		public function jump():void {
			if ( !_isJumping ) {
				_jumpVelocity += Constants.PLAYER_JUMP_SPEED;
			}
			_isJumping = true;
		}
		
		public function stopJumping():void {
			_isJumping = false;
		}
		
		public function startMovingLeft():void {
			if ( _isMovingRight ) {
				stopMovingRight();
			}
			if ( !_isMovingLeft ) {
				_lateralVelocity -= Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight():void {
			if ( _isMovingLeft ) {
				stopMovingLeft();
			}
			if ( !_isMovingRight ) {
				_lateralVelocity += Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingRight = true;
		}
		
		public function startDucking():void {
			_isDucking = true;
		}
		
		public function stopMovingLeft():void {
			if ( _isMovingLeft ) {
				_lateralVelocity += Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight():void {
			if ( _isMovingRight ) {
				_lateralVelocity -= Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingRight = false;
		}
		
		public function stopDucking():void {
			_isDucking = false;
		}
		
		public function get isJumping():Boolean {
			return _isJumping;
		}
		
		public function get isAirborne():Boolean {
			return _isAirborne;
		}
	}
}
