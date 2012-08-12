package com.funrun.model {

	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Stats;
	import com.funrun.model.vo.IPlaceable;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;

	public class PlayerModel extends Actor implements IPlaceable {
		
		// Player geometry.
		private var _mesh:Mesh;
		
		// Player properties.
		public var userId:String;
		public var name:String;
		private var _inGameId:int;
		private var _properties:Object;
		
		// Physical state.
		public var position:Vector3D;
		public var prevPosition:Vector3D;
		public var velocity:Vector3D;
		private var _place:int = 0;
		public var isDucking:Boolean = false;
		public var isOnTheGround:Boolean = true;
		public var isDead:Boolean = false;

		public function PlayerModel() {
			super();
			_properties = {};
			velocity = new Vector3D();
			position = new Vector3D();
			prevPosition = new Vector3D();
			resetInGameId();
		}
		
		public function resetInGameId():void {
			_inGameId = -1;
		}
		
		public function getDistanceFromPreviousPosition():Number {
			return position.subtract( prevPosition ).length;
		}
		
		public function updateMeshPosition():void {
			_mesh.x = position.x;
			_mesh.y = position.y;
			_mesh.z = position.z;
			prevPosition.x = position.x;
			prevPosition.y = position.y;
			prevPosition.z = position.z;
		}
		
		public function getMeshPosition():Vector3D {
			return _mesh.position;
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
		
		public function set mesh( m:Mesh ):void {
			_mesh = m;
		}
		
		public function get bounds():BoundingVolumeBase {
			return _mesh.bounds;
		}
		
		public function get scaleY():Number {
			return _mesh.scaleY;
		}
		
		public function set scaleY( value:Number ):void {
			_mesh.scaleY = value;
		}
		
		public function set inGameId( val:int ) {
			_inGameId = val;
		}
		
		public function get inGameId():int {
			return _inGameId;
		}
		
		public function get properties():Object {
			return _properties;
		}
		
		public function get bestDistance():Number {
			return _properties[ Stats.BEST_DISTANCE ];
		}
		
		public function set bestDistance( val:Number ) {
			_properties[ Stats.BEST_DISTANCE ] = val;
		}
		
		public function get points():Number {
			return _properties[ Stats.POINTS ];
		}
		
		public function set points( val:Number ) {
			_properties[ Stats.POINTS ] = val;
		}
	}
}
