package com.funrun.game.controller.events
{
	import away3d.entities.Mesh;
	
	import flash.events.Event;
	
	public class AddPlayerFulfilled extends Event
	{
		public static const ADD_PLAYER_FULFILLED:String = "AddPlayerFulfilled.ADD_PLAYER_FULFILLED";
		
		public var player:Mesh;
		
		public function AddPlayerFulfilled( type:String, player:Mesh ) {
			super( type );
			this.player = player;
		}
	}
}
