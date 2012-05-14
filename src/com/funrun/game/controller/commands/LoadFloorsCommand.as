package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.constants.BlockTypes;
	import com.funrun.game.model.constants.FloorTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.data.BoundingBoxData;
	import com.funrun.game.model.data.ObstacleData;
	
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
				mesh = new Mesh( geo, material );
				mesh.x = x - TrackConstants.TRACK_WIDTH * .5 + TrackConstants.BLOCK_SIZE * .5;
				mesh.y = TrackConstants.BLOCK_SIZE * -.5;
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
			floorsModel.addFloor( FloorTypes.FLOOR, new ObstacleData( floorMesh, boundingBoxes ) );
		}
	}
}
