package com.funrun.view
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	
	import com.funrun.model.ObstacleVO;
	
	import flash.geom.Vector3D;

	public class Obstacle extends ObjectContainer3D
	{
		public var id:String;
		private var _geos:Array;
		private var _prevZ:Number = 0;
		
		public function Obstacle( id:String )
		{
			super();
			this.id = id;
			_geos = [];
		}
		
		public function move( amount:Number ):void {
			_prevZ = z;
			z += amount;
		}
		
		public function addGeo( geo:Mesh ):void {
			_geos.push( geo );
			addChild( geo );
		}
		
		public function destroy():void {
			this.parent.removeChild( this );
			var len:int = _geos.length;
			var geo:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				geo = _geos[ i ];
				removeChild( geo );
				_geos[ i ] - null;
			}
			_geos = null;
		}
		
		public function get prevZ():Number {
			return _prevZ;
		}
	}
}