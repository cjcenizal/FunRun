package com.funrun.view.geo
{
	import away3d.entities.Mesh;

	public class BaseGeo
	{
		private var _geo;
		public function BaseGeo( geo:Mesh )
		{
			_geo = geo;
		}
		
		public function get geo():Mesh {
			return _geo;
		}
	}
}