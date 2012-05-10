package com.funrun.game.model {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	import com.funrun.game.model.constants.TrackConstants;
	
	public class TrackModel extends Actor {
		
		private var _obstacles:Array;
		
		public function TrackModel() {
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:Mesh ):void {
			// Add bounding boxes, ids, behaviors
			// Add geo (animations?)
			// Maintain links to geo in bounding boxes
			_obstacles.push( obstacle );
		}
		
		public function removeObstacle( obstacle:Mesh ):void {
			// Remove from geo somehow.
			// Remove obstacle from array.
		}
		
		public function move( amount:Number ):void {
			// Move all bounding boxes.
			// Move geo transform.
			var len:int = _obstacles.length;
			for ( var i:int = 0; i < len; i++ ) {
				( _obstacles[ i ] as Mesh ).z += amount;
			}
		}
		
		public function getCollisionsWidth( bounds:BoundingVolumeBase ):Vector.<BoundingVolumeBase> {
			// Get all blocks we collide with.
			return null;
		}
		
		public function removeObstacleAt( index:int ):void {
			_obstacles.splice( index, 1 );
		}
		
		public function getObstacleAt( index:int ):Mesh {
			return _obstacles[ index ];
		}
		
		public function get numObstacles():int {
			return _obstacles.length;
		}
		
		public function get depthOfLastObstacle():Number {
			if ( _obstacles.length > 0 ) {
				return ( _obstacles[ _obstacles.length - 1 ] as Mesh ).z;
			}
			return TrackConstants.TRACK_LENGTH;
		}
	}
}
