package com.funrun.model {

	import away3d.entities.Mesh;
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.model.vo.CollidableVo;
	import com.funrun.model.vo.IPlaceable;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;

	public class PlayerModel extends Actor implements IPlaceable {
		
		// Mesh.
		public var mesh:Mesh;
		
		// Player properties.
		public var userId:String;
		public var name:String;
		private var _inGameId:int;
		private var _properties:Object;
		private var _place:int = 0;
		
		// Physics.
		public var position:Vector3D;
		public var prevPosition:Vector3D;
		public var velocity:Vector3D;
		
		// Physical state.
		public var isDucking:Boolean = false;
		private var _isOnTheGround:Boolean = true;
		public var isDead:Boolean = false;
		
		// Jumping.
		private var _jumps:Number = 0;
		
		// Bounds.
		public var normalBounds:CollidableVo;
		public var duckingBounds:CollidableVo;

		public function PlayerModel() {
			super();
			_properties = {};
			velocity = new Vector3D();
			position = new Vector3D();
			prevPosition = new Vector3D();
			normalBounds = new CollidableVo();
			duckingBounds = new CollidableVo();
			resetInGameId();
		}
		
		public function resetInGameId():void {
			_inGameId = -1;
		}
		
		public function getDistanceFromPreviousPosition():Number {
			return position.subtract( prevPosition ).length;
		}
		
		public function updateMeshPosition():void {
			mesh.x = position.x;
			mesh.y = position.y;
			mesh.z = position.z;
			prevPosition.x = position.x;
			prevPosition.y = position.y;
			prevPosition.z = position.z;
		}
		
		public function jump():int {
			isOnTheGround = false;
			_jumps++;
			return _jumps - 1;
		}
		
		public function get jumps():int {
			return _jumps;
		}
		
		public function get canJump():Boolean {
			return _isOnTheGround || _jumps < Player.MAX_JUMPS;
		}
		
		public function set isOnTheGround( val:Boolean ):void {
			_isOnTheGround = val;
			if ( val ) _jumps = 0;
		}
		
		public function get isOnTheGround():Boolean {
			return _isOnTheGround;
		}
		
		public function get distance():Number {
			return position.z;
		}
		
		public function get distanceInFeet():int {
			return Math.round( distance / Block.SIZE );
		}
		
		public function get distanceString():String {
			return Numbers.addCommasTo( distanceInFeet.toString() );
		}
		
		public function set place( val:int ):void {
			_place = val;
		}
		
		public function get place():int {
			return _place;
		}
		
		public function get scaleY():Number {
			return mesh.scaleY;
		}
		
		public function set scaleY( value:Number ):void {
			mesh.scaleY = value;
		}
		
		public function set inGameId( val:int ):void {
			_inGameId = val;
		}
		
		public function get inGameId():int {
			return _inGameId;
		}
		
		public function get properties():Object {
			return _properties;
		}
		
		public function get highScore():Number {
			return _properties[ PlayerProperties.HIGH_SCORE ];
		}
		
		public function set highScore( val:Number ):void {
			_properties[ PlayerProperties.HIGH_SCORE ] = val;
		}
		
		public function get points():Number {
			return _properties[ PlayerProperties.POINTS ];
		}
		
		public function set points( val:Number ):void {
			_properties[ PlayerProperties.POINTS ] = val;
		}
		
		public function get color():String {
			return _properties[ PlayerProperties.COLOR ] || "red";
		}
		
		public function set color( val:String ):void {
			_properties[ PlayerProperties.COLOR ] = val;
		}
	}
}
