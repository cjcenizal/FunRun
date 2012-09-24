package com.funrun.model
{
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.BasicSpecularMethod;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.ShadowMapMethodBase;
	import away3d.materials.methods.SoftShadowMapMethod;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MaterialsModel extends Actor
	{
		
		private var _colorMaterials:Object;
		public var lightPicker:StaticLightPicker;
		public var shadowMethod:ShadowMapMethodBase;
		public var specular:int = -1;
		public var gloss:int = -1;
		public var specularMethod:BasicSpecularMethod;
		public var fogMethod:FogMethod;
		
		public function MaterialsModel()
		{
			super();
			_colorMaterials = {};
		}
		
		public function getColorMaterial( color:uint ):ColorMaterial {
			if ( !_colorMaterials[ color ] ) {
				var material:ColorMaterial = new ColorMaterial( color );
				if ( lightPicker ) material.lightPicker = lightPicker;
				if ( shadowMethod ) material.shadowMethod = shadowMethod;
				if ( specular >= 0 ) material.specular = specular;
				if ( gloss >= 0 ) material.gloss = gloss;
				if ( specularMethod ) material.specularMethod = specularMethod;
				if ( fogMethod ) material.addMethod( fogMethod );
				_colorMaterials[ color ] = material;
			}
			return _colorMaterials[ color ];
		}
	}
}