package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.collision.BlockData;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.vo.SegmentVO;
	import com.funrun.model.constants.BlockTypes;
	import com.funrun.model.constants.SegmentTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.ObstacleParser;
	import com.funrun.services.parsers.SegmentParser;
	import com.funrun.services.parsers.SegmentsParser;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadObstaclesCommand extends AsyncCommand {
		
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
		
		override public function execute():void {
			// Load all json files.
			var obstacleJson:Object = new JsonService().read( ObstaclesJsonData );
			var obstacleJsonFiles:Array = obstacleJson[ "list" ];
			for ( var i:int = 0; i < obstacleJsonFiles.length; i++ ) {
				var loader:URLLoader = new URLLoader( new URLRequest( _filePath + obstacleJsonFiles[ i ] ) );
				loader.addEventListener( IOErrorEvent.IO_ERROR, onJsonIoError );
				loader.addEventListener( Event.COMPLETE, onJsonLoaded );
			}
		}
		
		private function onJsonLoaded( e:Event ):void {
			// Parse and store obstacle.
			var json:String = ( e.target as URLLoader ).data;
			parseObstacle( new JsonService().readString( json ) );
			_countLoaded++;
			if ( _countLoaded == _countTotal ) {
				dispatchComplete( true );
			}
		}
		
		private function onJsonIoError( e:IOErrorEvent ):void {
			trace(this, "IOError");
		}
		
		private function parseObstacle( data:Object ):void {
			// Parse obstacle and add it to the model.
			var parsedObstacle:ObstacleParser = new ObstacleParser( data );
			segmentsModel.addSegment( parsedObstacle );
			
			
			/*
			var parsers:SegmentsParser = new SegmentsParser( json );
			var len:int = parsers.length;
			for ( var i:int = 0; i < len; i++ ) {
				var parser:SegmentParser = parsers.getAt( i );
				if ( parser.active ) {
					// Store this sucker.
					var segment:SegmentData = SegmentData.make( blocksModel, materialsModel, parser );
					if ( segment.depth != TrackConstants.SEGMENT_DEPTH ) {
						trace("WARNING in " + this + "! "
							+ parser.id + " is the wrong depth! It's " + segment.depth + " and it should be " + TrackConstants.SEGMENT_DEPTH
							+ ". It's off by " + ( ( TrackConstants.SEGMENT_DEPTH - segment.depth ) / TrackConstants.BLOCK_SIZE ) + " blocks.");
					} else {
						segmentsModel.addSegment( segment );
						if ( parser.flip ) {
							// Store mirror version if required.
							segmentsModel.addSegment( SegmentData.make( blocksModel, materialsModel, parser, true ) );
						}
					}
				}
			}
			*/
		}
		
		private function build():void {
			
			/*
			// Add a basic, empty floor.
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
		}
	}
}