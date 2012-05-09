package com.funrun.game.model {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.funrun.game.view.components.Obstacle;
	
	public class TrackModel {
		
		private var _obstacles:Array;
		private var _trackGeo:Mesh;
		
		public function TrackModel() {
			_obstacles = [];
		}
		
		public function addObstacle( obstacle:Obstacle ):void {
			// Add bounding boxes, ids, behaviors
			// Add geo (animations?)
			// Maintain links to geo in bounding boxes
			_obstacles.push( obstacle );
		}
		
		public function removeObstacle( obstacle:Obstacle ):void {
			// Remove from geo somehow.
			// Remove obstacle from array.
		}
		
		public function move( amount:Number ):void {
			// Move all bounding boxes
			// Move geo transform
		}
		
		public function getCollisionsWidth( bounds:BoundingVolumeBase ):Vector.<BoundingVolumeBase> {
			// Get all blocks we collide with.
		}
		
		public function trackGeo():Mesh {
			return _trackGeo;
		}
	}
}
