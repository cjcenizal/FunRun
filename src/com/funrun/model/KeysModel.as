package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class KeysModel extends Actor
	{
		
		private var _pressedKeys:Object
		
		public function KeysModel()
		{
			super();
			_pressedKeys = {};
		}
		
		public function down( key:uint ):void {
			_pressedKeys[ key ] = true;
		}
		
		public function up( key:uint ):void {
			_pressedKeys[ key ] = false;
		}
		
		public function isDown( key:uint ):Boolean {
			return _pressedKeys[ key ];
		}
		
		public function isUp( key:uint ):Boolean {
			return !_pressedKeys[ key ];
		}
	}
}