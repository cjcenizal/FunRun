package com.funrun.model
{
	import away3d.primitives.PrimitiveBase;

	public interface IGeosModel
	{
		function getGeo( id:String ):PrimitiveBase;
	}
}