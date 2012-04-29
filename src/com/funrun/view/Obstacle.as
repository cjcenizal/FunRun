package com.funrun.view
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.ObstacleVO;
	
	import flash.geom.Vector3D;

	public class Obstacle
	{
		public var id:String;
		private var _geos:Array;
		private var _z:Number = 0;
		private var _prevZ:Number = 0;
		
		public function Obstacle( id:String )
		{
			this.id = id;
			_geos = [];
		}
		
		public function move( amount:Number ):void {
			_prevZ = _z;
			_z += amount;
			var len:int = _geos.length;
			var geo:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				geo = _geos[ i ];
				geo.position = geo.position.add( new Vector3D( 0, 0, amount ) );
			}
		}
		
		public function addGeo( geo:Mesh ):void {
			_geos.push( geo );
		}
		
		public function destroy():void {
			
		}
		
		public function get z():Number {
			return _z;
		}
		
		public function get prevZ():Number {
			return _prevZ;
		}
	}
}