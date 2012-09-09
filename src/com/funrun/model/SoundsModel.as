package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class SoundsModel extends Actor
	{
		
		public var folder:String = "";
		private var _sounds:Object;
		
		public function SoundsModel()
		{
			super();
			_sounds = {};
		}
		
		public function add( id:String, filepath:String ):void {
			if ( !_sounds[ id ] ) _sounds[ id ] = new Array();
			( _sounds[ id ] as Array ).push( filepath );
		}
		
		public function getFilepath( id:String ):String {
			if ( _sounds[ id ] ) {
				var sounds:Array = _sounds[ id ] as Array;
				return folder + sounds[ Math.floor( Math.random() * sounds.length ) ];
			}
			return null;
		}
	}
}