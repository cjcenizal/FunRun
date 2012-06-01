package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class PlacesModel extends Actor
	{
		
		private var _placeables:Array;
		
		public function PlacesModel()
		{
			super();
			_placeables = [];
		}
	}
}