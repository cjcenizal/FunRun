package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.BlockTypes;
	import com.funrun.model.constants.FloorTypes;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class LoadFloorsCommand extends Command {

		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		override public function execute():void {
			
			var geo:PrimitiveBase, mesh:Mesh, material:ColorMaterial;
			var merge:Merge = new Merge( true );
			geo = blocksModel.getBlock( BlockTypes.FLOOR ).geo;
			material = materialsModel.getMaterial( MaterialsModel.GROUND_MATERIAL );
			var floorMesh:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material );
			var boundingBoxes:Array = [];
			for ( var x:int = 0; x < TrackConstants.TRACK_WIDTH; x += TrackConstants.BLOCK_SIZE ) {
				for ( var z:int = 0; z < TrackConstants.SEGMENT_DEPTH; z += TrackConstants.BLOCK_SIZE ) {
					mesh = new Mesh( geo, material );
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
			
			floorsModel.addFloor( FloorTypes.FLOOR, new ObstacleData( floorMesh, boundingBoxes, minX, minY, minZ, maxX, maxY, maxZ ) );
		}
	}
}
