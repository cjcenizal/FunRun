package com.funrun.game.model
{
	import com.funrun.game.view.geo.EmptyGeo;
	import com.funrun.game.view.geo.BeamGeo;
	import com.funrun.game.view.geo.LedgeGeo;
	import com.funrun.game.view.geo.WallGeo;

	public class GeosModel
	{
		private var _geos:Object;
		
		public function GeosModel()
		{
			_geos = {
				"empty" : EmptyGeo,
				"ledge" : LedgeGeo,
				"wall" : WallGeo,
				"beam" : BeamGeo
			}
		}
	}
}