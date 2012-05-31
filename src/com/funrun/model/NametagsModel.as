package com.funrun.model {

	import com.cenizal.ui.AbstractLabel;
	
	import org.robotlegs.mvcs.Actor;

	public class NametagsModel extends Actor {
		
		private var _nametags:Object;
		
		public function NametagsModel() {
			super();
			_nametags = {};
		}
		
		public function reset():void {
			for ( var key:String in _nametags ) {
				getWithId( key ).destroy();
				delete _nametags[ key ];
			}
			_nametags = {};
		}
		
		public function add( id:int, nametag:AbstractLabel ):void {
			_nametags[ id ] = nametag;
		}
		
		public function getWithId( id:String ):AbstractLabel {
			return _nametags[ id ];
		}
	}
}
