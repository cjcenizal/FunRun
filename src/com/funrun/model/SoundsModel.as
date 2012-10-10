package com.funrun.model
{
	import flash.media.Sound;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SoundsModel extends Actor
	{
		
		private var _sounds:Object;
		private var _soundsArr:Array;
		
		public function SoundsModel()
		{
			super();
			_sounds = {};
			_soundsArr = [];
		}
		
		public function add( id:String, sound:Sound ):void {
			if ( !_sounds[ id ] ) _sounds[ id ] = new Array();
			( _sounds[ id ] as Array ).push( sound );
			_soundsArr.push( sound );
		}
		
		public function getWithId( id:String ):Sound {
			if ( _sounds[ id ] ) {
				var sounds:Array = _sounds[ id ] as Array;
				return sounds[ Math.floor( Math.random() * sounds.length ) ];
			}
			return null;
		}
	}
}