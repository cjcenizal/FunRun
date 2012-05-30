package com.funrun.model.vo {

	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;

	public class CompetitorVO {

		private var _id:int;
		private var _mesh:Mesh;
		private var _velocity:Vector3D;
		private var _isDead:Boolean;
		private var _isDucking:Boolean;
		private var _oldPosition:Vector3D;
		private var _newPosition:Vector3D;

		public function CompetitorVO( id:int, mesh:Mesh, velocity:Vector3D, isDead:Boolean, isDucking:Boolean ) {
			_id = id;
			_mesh = mesh;
			_velocity = velocity;
			_isDead = isDead;
			_isDucking = isDucking;
			_oldPosition = new Vector3D();
			_newPosition = new Vector3D();
		}
		
		public function updatePosition( x:Number, y:Number, z:Number ):void {
			_oldPosition.x = _newPosition.x;
			_oldPosition.y = _newPosition.y;
			_oldPosition.z = _newPosition.z;
			_newPosition.x = x;
			_newPosition.y = y;
			_newPosition.z = z;
		}
		
		public function hardUpdate():void {
			_mesh.x = _newPosition.x;
			_mesh.y = _newPosition.y;
			_mesh.z = _newPosition.z;
		}
		
		public function interpolate( pct:Number ):void {
			_mesh.x = _oldPosition.x + ( _newPosition.x - _oldPosition.x ) * pct;
			_mesh.y = _oldPosition.y + ( _newPosition.y - _oldPosition.y ) * pct;
			_mesh.z = _oldPosition.z + ( _newPosition.z - _oldPosition.z ) * pct;
		}
		
		public function get id():int {
			return _id;
		}
		
		public function get velocity():Vector3D {
			return _velocity;
		}
		
		public function get mesh():Mesh {
			return _mesh;
		}
	}
}
