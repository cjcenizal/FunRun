package com.funrun.model.vo {

	import away3d.entities.Mesh;
	
	
	import flash.geom.Vector3D;

	public class CompetitorVo implements IPlaceable {

		public var mesh:Mesh;
		public var isDucking:Boolean;
		public var liveIndex:int = 0;
		private var _id:int;
		private var _name:String;
		private var _oldPosition:Vector3D;
		private var _newPosition:Vector3D;
		private var _place:int = 0;
		private var _isDead:Boolean = false;
		private var _deathTime:Number = 0;
		
		public function CompetitorVo( id:int, name:String ) {
			_id = id;
			_name = name;
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
			mesh.x = _oldPosition.x = _newPosition.x;
			mesh.y = _oldPosition.y = _newPosition.y;
			mesh.z = _oldPosition.z = _newPosition.z;
		}
		
		public function interpolate( pct:Number ):void {
			mesh.x = _oldPosition.x + ( _newPosition.x - _oldPosition.x ) * pct;
			mesh.y = _oldPosition.y + ( _newPosition.y - _oldPosition.y ) * pct;
			mesh.z = _oldPosition.z + ( _newPosition.z - _oldPosition.z ) * pct;
		}
		
		public function kill():void {
			_isDead = true;
			_deathTime = new Date().getTime();
		}
		
		public function get position():Vector3D {
			return _newPosition;
		}
		
		public function get id():int {
			return _id;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function get distance():Number {
			return ( mesh ) ? mesh.z : 0;
		}
		
		public function set place( val:int ):void {
			_place = val;
		}
		
		public function get place():int {
			return _place;
		}
		
		public function get isDead():Boolean {
			return _isDead;
		}
		
		public function get deathTime():Number {
			return _deathTime;
		}
	}
}
