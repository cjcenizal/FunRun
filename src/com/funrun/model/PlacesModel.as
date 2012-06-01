package com.funrun.model {

	import org.robotlegs.mvcs.Actor;

	public class PlacesModel extends Actor {

		private var _placeables:Array;

		public function PlacesModel() {
			super();
			_placeables = [];
		}
		
		public function add( placeable:IPlaceable ):void {
			_placeables.push( placeable );
		}
		
		public function remove( placeable:IPlaceable ):void {
			for ( var i:int = 0; i < _placeables.length; i++ ) {
				if ( _placeables[ i ] == placeable ) {
					_placeables.splice( i, 1 );
					return;
				}
			}
		}
		
		public function sortPlaces():void {
			_placeables.sortOn( "distance" );
		}
	}
}
