package com.funrun.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.tools.commands.Merge;
	
	import com.funrun.model.BlocksModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.collision.BoundingBoxData;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.vo.SegmentVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class StoreFloorCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		override public function execute():void {
			var floorMesh:Mesh = new Mesh();
			var merge:Merge = new Merge( true );
			var boundingBoxes:Array = [];
			var floorBlockRefMesh:Mesh = blocksModel.getBlock( "001" ).mesh;
			var floorBlockMesh:Mesh;
			var posX:Number, posZ:Number;
			for ( var x:int = 0; x <= Segment.NUM_BLOCKS_WIDE; x++ ) {
				posX = x + .5;
				for ( var z:int = 0; z <= Segment.NUM_BLOCKS_DEPTH; z++ ) {
					posZ = z + .5;
					// Put floor blocks everywhere.
					// Create a floor block mesh in the appropriate place.
					floorBlockMesh = floorBlockRefMesh.clone() as Mesh;
					floorBlockMesh.x = posX * Block.SIZE;
					floorBlockMesh.y = -Block.SIZE;
					floorBlockMesh.z = posZ * Block.SIZE;
					// Merge it into the obstacle.
					merge.apply( floorMesh, floorBlockMesh );
					// Add a bounding box so we can collide with the floor.
					boundingBoxes.push( new BoundingBoxData(
						blocksModel.getBlock( "001" ),
						floorBlockMesh.x, floorBlockMesh.z, floorBlockMesh.z,
						floorBlockMesh.x - Block.HALF_SIZE,
						floorBlockMesh.y - Block.HALF_SIZE,
						floorBlockMesh.z - Block.HALF_SIZE,
						floorBlockMesh.x + Block.HALF_SIZE,
						floorBlockMesh.y + Block.HALF_SIZE,
						floorBlockMesh.z + Block.HALF_SIZE
					) );
				}
			}
			
			var floor:SegmentVO = new SegmentVO( "floor", floorMesh, boundingBoxes,
				floorMesh.bounds.min.x, floorMesh.bounds.min.y, floorMesh.bounds.min.z,
				floorMesh.bounds.max.x, floorMesh.bounds.max.y, floorMesh.bounds.max.z );
			segmentsModel.storeFloor( floor );
		}
	}
}