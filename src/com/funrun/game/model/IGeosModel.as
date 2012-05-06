package com.funrun.game.model
{
	import away3d.primitives.PrimitiveBase;

	public interface IGeosModel
	{
		function getGeo( id:String ):PrimitiveBase;
	}
}