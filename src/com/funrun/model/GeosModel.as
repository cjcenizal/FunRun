package com.funrun.model
{
	import com.funrun.view.geo.EmptyGeo;
	import com.funrun.view.geo.BeamGeo;
	import com.funrun.view.geo.LedgeGeo;
	import com.funrun.view.geo.WallGeo;

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