package com.funrun.model
{
	import com.funrun.model.geo.EmptyGeo;
	import com.funrun.model.geo.BeamGeo;
	import com.funrun.model.geo.LedgeGeo;
	import com.funrun.model.geo.WallGeo;

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