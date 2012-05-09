package com.funrun.game.model {
	
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.model.parsers.BlockVO;
	import com.funrun.game.model.parsers.ObstacleParser;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObstaclesModel extends Actor {
		
		private var _obstacles:Array;
		private var _length:int = 0;
		
		public function ObstaclesModel() {
			_obstacles = [];
		}
		
		/**
		 * 
		 */
		public function addObstacle( obstacle:Mesh ):void {
			_obstacles.push( obstacle );
			_length++;
		}
		
		public function getRandomObstacle():Mesh {
			return _obstacles[ Math.floor( Math.random() * _length ) ];
		}
	}
}
