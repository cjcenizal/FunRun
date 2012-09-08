package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class ColorsModel extends Actor
	{
		
		private var _colors:Object;
		private var _colorsArr:Array;
		
		public function ColorsModel()
		{
			super();
			_colors = {};
			_colors[ "red" ] = 0xff0000;
			_colors[ "orange" ] = 0xfea412;
			_colors[ "gold" ] = 0xf4c70c;
			_colors[ "lime" ] = 0x7ada43;
			_colors[ "green" ] = 0x11c12e;
			_colors[ "cyan" ] = 0x4addc6;
			_colors[ "teal" ] = 0x3487bc;
			_colors[ "blue" ] = 0x5e96ea;
			_colors[ "purple" ] = 0x755eea;
			_colors[ "violet" ] = 0xe263e1;
			_colors[ "pink" ] = 0xff367d;
			_colorsArr = [];
			for ( var key:String in _colors ) {
				_colorsArr.push( _colors[ key ] );
			}
		}
		
		public function getColor( id:String ):uint {
			return _colors[ id ];
		}
		
		public function getColorAt( index:int ):uint {
			return _colorsArr[ index ];
		}
		
		public function get numColors():int {
			return _colorsArr.length;
		}
	}
}