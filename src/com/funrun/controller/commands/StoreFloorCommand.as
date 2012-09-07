package com.funrun.controller.commands
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.BoundingBoxVo;
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class StoreFloorCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			var floorMesh:Mesh = new Mesh( new Geometry() );
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			var floorBlockRefMesh:Mesh = blocksModel.getBlock( "floor" ).mesh;
			var floorBlockMesh:Mesh;
			var posX:Number, posZ:Number;
			for ( var x:int = 0; x < Segment.WIDTH_BLOCKS; x++ ) {
				posX = x;
				for ( var z:int = 0; z < Segment.DEPTH_BLOCKS; z++ ) {
					posZ = z;
					// Put floor blocks everywhere.
					// Create a floor block mesh in the appropriate place.
					floorBlockMesh = floorBlockRefMesh.clone() as Mesh;
					floorBlockMesh.x = posX * Block.SIZE + .5 * Block.SIZE;
					floorBlockMesh.y = -1 * Block.SIZE;
					floorBlockMesh.z = posZ * Block.SIZE + .5 * Block.SIZE;
					// Merge it into the obstacle.
					merge.apply( floorMesh, floorBlockMesh );
					// Add a bounding box so we can collide with the floor.
					boundingBoxes.push( new BoundingBoxVo(
						i, blocksModel.getBlock( "floor" ),
						floorBlockMesh.x, floorBlockMesh.y, floorBlockMesh.z,
						-Block.HALF_SIZE,
						-Block.HALF_SIZE,
						-Block.HALF_SIZE,
						Block.HALF_SIZE,
						Block.HALF_SIZE,
						Block.HALF_SIZE
					) );
				}
			}
			
			// Add a bounds indicator.
			var boundsMesh:Mesh = null;
			if ( showBoundsState.showBounds ) {
				boundsMesh = new Mesh( new Geometry() );
				var blockGeo:Geometry = new CubeGeometry( Block.SIZE, Block.SIZE, Block.SIZE );
				var len:int = boundingBoxes.length;
				var box:BoundingBoxVo;
				var indicator:Mesh;
				for ( var i:int = 0; i < len; i++ ) {
					box = boundingBoxes[ i ];
					indicator = new Mesh( blockGeo, Materials.DEBUG_BLOCK );
					indicator.x = box.x;
					indicator.y = box.y;
					indicator.z = box.z;
					merge.apply( boundsMesh, indicator );
				}
			}
			
			var floor:SegmentVo = new SegmentVo( floorMesh, boundsMesh, boundingBoxes,
				floorMesh.bounds.min.x, floorMesh.bounds.min.y, floorMesh.bounds.min.z,
				floorMesh.bounds.max.x, floorMesh.bounds.max.y, floorMesh.bounds.max.z );
			segmentsModel.storeFloor( floor );
		}
	}
}