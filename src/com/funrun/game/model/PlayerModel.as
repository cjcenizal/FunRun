package com.funrun.game.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PlayerModel extends Actor
	{
		// Player geometry.
		private var _player:Mesh;
		
		public function PlayerModel()
		{
			super();
		}
		
		public function get player():Mesh {
			return _player;
		}
		
		public function set player( p:Mesh ):void {
			_player = p;
		}
	}
}