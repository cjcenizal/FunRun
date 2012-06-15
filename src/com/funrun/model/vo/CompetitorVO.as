package com.funrun.model.vo {

	import away3d.entities.Mesh;
	
	import com.funrun.model.IPlaceable;
	
	import flash.geom.Vector3D;

	public class CompetitorVO implements IPlaceable {

		public var mesh:Mesh;
		public var isDead:Boolean;
		public var isDucking:Boolean;
		public var liveIndex:int = 0;
		private var _id:int;
		private var _name:String;
		private var _oldPosition:Vector3D;
		private var _newPosition:Vector3D;
		private var _place:int = 0;
		
		public function CompetitorVO( id:int, name:String ) {
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
	}
}
