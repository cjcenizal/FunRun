package com.funrun.game.view.events {
	import flash.events.Event;

	public class CollisionEvent extends Event {
		
		public static const COLLISION:String = "COLLISION";
		
		public function CollisionEvent( type:String ) {
			super( type );
		}
	}
}
