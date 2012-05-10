package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.BlockTypes;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.MaterialsModel;
	
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
			var floor:Mesh = new Mesh( new CubeGeometry( 0, 0, 0 ), material );
			for ( var x:int = 0; x < Constants.TRACK_WIDTH; x += Constants.BLOCK_SIZE ) {
				mesh = new Mesh( geo, material );
				mesh.x = x - Constants.TRACK_WIDTH * .5 + Constants.BLOCK_SIZE * .5;
				mesh.y = Constants.BLOCK_SIZE * -.5;
				merge.apply( floor, mesh );
			}
			floorsModel.addFloor( "floor", floor );
		}
	}
}
