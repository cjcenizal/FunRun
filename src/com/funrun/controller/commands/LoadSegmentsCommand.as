package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.collision.SegmentData;
	import com.funrun.model.constants.BlockTypes;
	import com.funrun.model.constants.SegmentTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.services.ObstaclesJsonService;
	import com.funrun.services.parsers.SegmentParser;
	import com.funrun.services.parsers.SegmentsParser;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadSegmentsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		// Services.
		
		[Inject]
		public var obstaclesService:ObstaclesJsonService;
		
		override public function execute():void {
			
			// Load temp floor.
			// TO-DO: Put floor(s) into json.
			var referenceMesh:Mesh, mesh:Mesh;//, floorMaterial:MaterialBase;
			var merge:Merge = new Merge( true );
			referenceMesh = blocksModel.getBlock( BlockTypes.FLOOR ).mesh;
			trace("referenceMesh: "+ referenceMesh);
			//floorMaterial = materialsModel.getMaterial( MaterialsModel.FLOOR_MATERIAL );
			//var floorMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), floorMaterial );
			/*var boundingBoxes:Array = [];
			for ( var x:int = 0; x < TrackConstants.TRACK_WIDTH; x += TrackConstants.BLOCK_SIZE ) {
				for ( var z:int = 0; z < TrackConstants.SEGMENT_DEPTH; z += TrackConstants.BLOCK_SIZE ) {
					mesh = referenceMesh.clone() as Mesh;//new Mesh( referenceMesh.geometry, referenceMesh.material );
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
			var parsers:SegmentsParser = new SegmentsParser( obstaclesService.data );
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
		}
	}
}