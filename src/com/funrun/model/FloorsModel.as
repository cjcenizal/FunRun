package com.funrun.model {
	
	import away3d.entities.Mesh;
	
	import com.funrun.model.collision.ObstacleData;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FloorsModel extends Actor {
		
		private var _floors:Object;
		
		public function FloorsModel() {
			super();
			_floors = {};
		}
		
		public function addFloor( id:String, floor:ObstacleData ):void {
			_floors[ id ] = floor;
		}
		
		public function getFloorClone( id:String ):ObstacleData {
			return ( _floors[ id ] as ObstacleData ).clone();
		}
	}
}
