package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.tools.commands.Merge;
	
	import com.funrun.controller.signals.StoreObstacleRequest;
	import com.funrun.model.BlocksModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.constants.BlockTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.model.vo.ObstacleBlockVO;
	import com.funrun.model.vo.SegmentVO;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.ObstacleParser;
	import com.funrun.services.parsers.ObstaclesListParser;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	/**
	 * Parse a json file and store a mesh constructed out of template blocks.
	 */
	public class LoadObstaclesCommand extends AsyncCommand {
		
		// Commands.
		
		[Inject]
		public var storeObstacleRequest:StoreObstacleRequest;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "obstacles/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			// Load list of obstacles.
			_loader = new URLLoader( new URLRequest( 'data/obstacles.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse list of obstacles.
			var parsedObstaclesList:ObstaclesListParser = new ObstaclesListParser( new JsonService().readString( data ) );
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedObstaclesList.length;
			_countTotal = len;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Load each obstacle, construct it, and store the mesh.
				for ( var i:int = 0; i < len; i++ ) {
					var filename:String = parsedObstaclesList.getAt( i );
					var loader:URLLoader = new URLLoader( new URLRequest( _filePath + filename ) );
					loader.addEventListener( Event.COMPLETE, getOnObstacleLoaded( filename ) );
				}
			}
			
		}
		
		private function getOnObstacleLoaded( filename:String ):Function {
			var completeCallback:Function = this.dispatchComplete;
			var storeObstacleRequest:Signal = this.storeObstacleRequest;
			return function( e:Event ):void {
				var data:String = ( e.target as URLLoader ).data;
				var json:Object = new JsonService().readString( data );
				// Construct and store obstacle.
				storeObstacleRequest.dispatch( json );
				// Increment complete count and check if we're done.
				_countLoaded++;
				if ( _countLoaded == _countTotal ) {
					completeCallback.call( null, true );
				}
			}
		}
		
		/*
		[ Embed( source = "external/embed/data/obstacles.json", mimeType = "application/octet-stream" ) ]
		private const ObstaclesJsonData:Class;
		
		// Models.
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		// Private vars.
		
		private var _filePath:String = "obstacles/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {*/
			// TO-DO: Add a default floor segment.
			/*
			var merge:Merge = new Merge( true );
			var referenceBlock:BlockVO = blocksModel.getBlock( BlockTypes.FLOOR );
			var referenceMesh:Mesh = referenceBlock.mesh;
			var floorMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), referenceBlock.mesh.material );
			var boundingBoxes:Array = [];
			var mesh:Mesh;
			for ( var x:int = 0; x < TrackConstants.TRACK_WIDTH; x += TrackConstants.BLOCK_SIZE ) {
				for ( var z:int = 0; z < TrackConstants.SEGMENT_DEPTH; z += TrackConstants.BLOCK_SIZE ) {
					mesh = new Mesh( referenceMesh.geometry, referenceMesh.material );
					mesh.x = x - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE_HALF;
					mesh.y = -TrackConstants.BLOCK_SIZE_HALF;
					mesh.z = z + TrackConstants.BLOCK_SIZE_HALF;
					merge.apply( floorMesh, mesh );
					
					// Add a bounding box so we can collide with the floor.
					boundingBoxes.push( new BoundingBoxData(
						blocksModel.getBlock( BlockTypes.FLOOR ),
						mesh.x, mesh.y, mesh.z,
						mesh.x - TrackConstants.BLOCK_SIZE_HALF,
						mesh.y - TrackConstants.BLOCK_SIZE_HALF,
						mesh.z - TrackConstants.BLOCK_SIZE_HALF,
						mesh.x + TrackConstants.BLOCK_SIZE_HALF,
						mesh.y + TrackConstants.BLOCK_SIZE_HALF,
						mesh.z + TrackConstants.BLOCK_SIZE_HALF
					) );
				}
			}
			// Store bounds.
			var minX:Number = TrackConstants.TRACK_WIDTH * -.5;
			var maxX:Number = TrackConstants.TRACK_WIDTH * .5;
			var minY:Number = -TrackConstants.BLOCK_SIZE_HALF;
			var maxY:Number = TrackConstants.BLOCK_SIZE_HALF;
			var minZ:Number = 0;
			var maxZ:Number = TrackConstants.SEGMENT_DEPTH;
			segmentsModel.addSegment( new SegmentData( SegmentTypes.FLOOR, floorMesh, boundingBoxes, minX, minY, minZ, maxX, maxY, maxZ ) );
			*/
			
			// Load all json files.
		/*	var obstacleJson:Object = new JsonService().read( ObstaclesJsonData );
			var obstacleJsonFiles:Array = obstacleJson[ "list" ];
			var len:int = _countTotal = obstacleJsonFiles.length;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				for ( var i:int = 0; i < len; i++ ) {
					var filePath:String = _filePath + obstacleJsonFiles[ i ];
					var loader:URLLoader = new URLLoader( new URLRequest( filePath ) );
					loader.addEventListener( IOErrorEvent.IO_ERROR, onJsonIoError );
					loader.addEventListener( Event.COMPLETE, onJsonLoaded );
				}
			}
		}
		
		private function onJsonLoaded( e:Event ):void {
			// Parse and store obstacle.
			var json:String = ( e.target as URLLoader ).data;
			// TO-DO: Transfer id to obstacle, using BulkLoader possibly.
			parseObstacle(  "placeHolderId", new JsonService().readString( json ) as Array );
			_countLoaded++;
			if ( _countLoaded == _countTotal ) {
				dispatchComplete( true );
			}
		}
		
		private function onJsonIoError( e:IOErrorEvent ):void {
			trace(this, "IOError");
		}
		
		private function parseObstacle( id:String, data:Array ):void {
			
			// TO-DO:
			// We need to be able to specify here that some blocks on top of pit edges
			// need to be walkable and not obstacle.
			
			// Parse obstacle and add it to the model.
			var parsedObstacle:ObstacleParser = new ObstacleParser( data );
			
			// Set up obstacle mesh vars.
			var blockData:ObstacleBlockVO;
			var block:BlockVO;
			var blockMesh:Mesh;
			var obstacleMesh:Mesh = new Mesh();
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			
			// A map of all pit locations in the obstacle.
			var pitMap:Object = makePitMap();
			
			// Traverse block data and construct an obstacle mesh, filling in floors where necessary.
			var len:int = parsedObstacle.numBlockData;
			for ( var i:int = 0; i < len; i++ ) {
				// Get position and mesh data for particular block.
				blockData = parsedObstacle.getBlockDataAt( i );
				block = blocksModel.getBlock( blockData.id );
				// Create and position a mesh from data.
				blockMesh = block.mesh.clone() as Mesh;
				blockMesh.x = blockData.x * TrackConstants.BLOCK_SIZE;
				blockMesh.y = blockData.y * TrackConstants.BLOCK_SIZE;
				blockMesh.z = blockData.z * TrackConstants.BLOCK_SIZE;
				// Merge the block mesh into the obstacle mesh.
				merge.apply( obstacleMesh, blockMesh );
				// Add a bounding box so we can collide with the obstacle.
				boundingBoxes.push( new BoundingBoxData(
					blocksModel.getBlock( blockData.id ),
					blockMesh.x, blockMesh.y, blockMesh.z,
					blockMesh.x - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.y - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.z - TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.x + TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.y + TrackConstants.BLOCK_SIZE_HALF,
					blockMesh.z + TrackConstants.BLOCK_SIZE_HALF
				) );
				// If the block is below ground-level, it signals a pit.
				if ( blockData.y < 0 ) {
					// So mark it as positive in the pitmap.
					markPitAt( pitMap, blockData.x, blockData.z );
				}
			}
			*/
			/*
			// Fill in floors where necessary.
			var floorBlockRefMesh:Mesh = blocksModel.getBlock( BlockTypes.FLOOR ).mesh;
			var floorBlockMesh:Mesh;
			for ( var x:int = minX; x <= maxX; x++ ) {
				for ( var z:int = minZ; z <= maxZ; z++ ) {
					// Put floor blocks wherever the pit map is negative.
					if ( !pitMap[ x ] || !pitMap[ x ][ z ] ) {
						// Create a floor block mesh in the appropriate place.
						floorBlockMesh = floorBlockRefMesh.clone() as Mesh;
						floorBlockMesh.x = x * TrackConstants.BLOCK_SIZE - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
						floorBlockMesh.y = TrackConstants.BLOCK_SIZE * -.5;
						floorBlockMesh.z = z * TrackConstants.BLOCK_SIZE + TrackConstants.BLOCK_SIZE * .5;
						// Merge it into the obstacle.
						merge.apply( obstacleMesh, floorBlockMesh );
						// Add a bounding box so we can collide with the floor.
						boundingBoxes.push( new BoundingBoxData(
							blocksModel.getBlock( BlockTypes.FLOOR ),
							floorBlockMesh.x, floorBlockMesh.z, floorBlockMesh.z,
							floorBlockMesh.x - TrackConstants.BLOCK_SIZE_HALF,
							floorBlockMesh.y - TrackConstants.BLOCK_SIZE_HALF,
							floorBlockMesh.z - TrackConstants.BLOCK_SIZE_HALF,
							floorBlockMesh.x + TrackConstants.BLOCK_SIZE_HALF,
							floorBlockMesh.y + TrackConstants.BLOCK_SIZE_HALF,
							floorBlockMesh.z + TrackConstants.BLOCK_SIZE_HALF
						) );
					}
				}
			}*/
			
		/*	var segment:SegmentVO = new SegmentVO( id, BlockTypes.OBSTACLE, obstacleMesh, boundingBoxes,
				obstacleMesh.bounds.min.x, obstacleMesh.bounds.min.y, obstacleMesh.bounds.min.z,
				obstacleMesh.bounds.max.x, obstacleMesh.bounds.max.y, obstacleMesh.bounds.max.z );
			segmentsModel.addSegment( segment );
			
			trace("Bounds for " + segment.id);
			trace("x: " + obstacleMesh.bounds.min.x + ", " + obstacleMesh.bounds.max.x);
			trace("y: " + obstacleMesh.bounds.min.y + ", " + obstacleMesh.bounds.max.y);
			trace("z: " + obstacleMesh.bounds.min.z + ", " + obstacleMesh.bounds.max.z);
		}
		
		private function makePitMap():Object {
			// TO-DO: Import a Maya obstacle with pits to make sure this logic is sound.
			var pitMap:Object = {};
			for ( var x:Number = 0; x < 12; x++ ) {
				pitMap[ x ] = {};
				for ( var z:Number = 0; z < 24; z++ ) {
					pitMap[ x ][ z ] = false;
				}
			}
			return pitMap;
		}
		
		private function markPitAt( pitMap:Object, posX:Number, posZ:Number ):void {
			// TO-DO: Import a Maya obstacle with pits to make sure this logic is sound, and pits are being marked where I expect them to be.
			pitMap[ Math.round( posX - .5 ) ][ Math.round( posZ - .5 ) ] = true;
		}*/
	}
}