package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;

	public class StateModel extends Actor
	{
		public var canDie:Boolean = false;
		public var canMoveForward:Boolean = false;
		
		public function StateModel() {
			super();
		}
	}
}