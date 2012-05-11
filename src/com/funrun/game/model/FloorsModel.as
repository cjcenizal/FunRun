package com.funrun.game.model {
	
	import away3d.entities.Mesh;
	
	import com.funrun.game.model.data.ObstacleData;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FloorsModel extends Actor {
		
		private var _floors:Object;
		
		public function FloorsModel() {
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
