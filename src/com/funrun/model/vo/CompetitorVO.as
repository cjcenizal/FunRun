package com.funrun.model.vo {

	import away3d.entities.Mesh;
	
	import com.funrun.services.animation.CharacterController;
	
	import flash.geom.Vector3D;

	public class CompetitorVo implements IPlaceable {

		public var isDucking:Boolean;
		public var liveIndex:int = 0;
		public var isReady:Boolean = false;
		private var _id:int;
		private var _name:String;
		private var _oldPosition:Vector3D;
		private var _newPosition:Vector3D;
		private var _place:int = 0;
		private var _isDead:Boolean = false;
		private var _deathTime:Number = 0;
		private var _characterController:CharacterController;
		public var aiVelocity:Vector3D;
		
		public function CompetitorVo( id:int, name:String, character:CharacterVo ) {
			_id = id;
			_name = name;
			_characterController = new CharacterController();
			_characterController.setCharacter( character );
			_oldPosition = new Vector3D();
			_newPosition = new Vector3D();
		}
		
		public function updatePosition():void {
			_characterController.updatePosition();
		}
		
		public function setTargetPosition( x:Number, y:Number, z:Number ):void {
			_oldPosition.x = _newPosition.x;
			_oldPosition.y = _newPosition.y;
			_oldPosition.z = _newPosition.z;
			_newPosition.x = x;
			_newPosition.y = y;
			_newPosition.z = z;
		}
		
		public function hardUpdatePosition():void {
			_characterController.mesh.x = _oldPosition.x = _newPosition.x;
			_characterController.mesh.y = _oldPosition.y = _newPosition.y;
			_characterController.mesh.z = _oldPosition.z = _newPosition.z;
		}
		
		public function interpolateToTargetPosition( pct:Number ):void {
			_characterController.position.x = _oldPosition.x + ( _newPosition.x - _oldPosition.x ) * pct;
			_characterController.position.y = _oldPosition.y + ( _newPosition.y - _oldPosition.y ) * pct;
			_characterController.position.z = _oldPosition.z + ( _newPosition.z - _oldPosition.z ) * pct;
		}
		
		public function stand():void {
			_characterController.stand();
		}
		
		public function run():void {
			_characterController.run();
		}
		
		public function kill():void {
			_isDead = true;
			var d:Date = new Date();
			_deathTime = d.getTime();
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
		
		public function get characterId():String {
			return _characterController.character.id;
		}
		
		public function get distance():Number {
			return ( _characterController.mesh ) ? _characterController.mesh.z : 0;
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
		
		public function get mesh():Mesh {
			return _characterController.mesh;
		}
		
		public function get vector():Vector3D {
			return _characterController.vector;
		}
		
		public function get prevVector():Vector3D {
			return _characterController.prevVector;
		}
	}
}
