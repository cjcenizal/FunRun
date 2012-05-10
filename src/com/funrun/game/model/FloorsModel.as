package com.funrun.game.model {
	
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FloorsModel extends Actor {
		
		private var _floors:Object;
		
		public function FloorsModel() {
			_floors = {};
		}
		
		public function addFloor( id:String, floor:Mesh ):void {
			_floors[ id ] = floor;
		}
		
		public function getFloor( id:String ):Mesh {
			return _floors[ id ];
		}
	}
}
