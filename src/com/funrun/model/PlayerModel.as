package com.funrun.model {

	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.transitions.CrossfadeStateTransition;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.CharacterAnimations;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.model.vo.CharacterVo;
	import com.funrun.model.vo.CollidableVo;
	import com.funrun.model.vo.IPlaceable;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;

	public class PlayerModel extends Actor implements IPlaceable {
		
		// Mesh.
		public var mesh:Mesh;
		private var _character:CharacterVo;
		private var _animator:SkeletonAnimator;
		
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
		private var _targetRotation:Number = 0;
		
		// Jumping.
		private var _jumps:Number = 0;
		
		// Bounds.
		public var normalBounds:CollidableVo;
		public var duckingBounds:CollidableVo;
		
		// Animations.
		private var _stateTransition:CrossfadeStateTransition;

		public function PlayerModel() {
			super();
			_properties = {};
			velocity = new Vector3D();
			position = new Vector3D();
			prevPosition = new Vector3D();
			normalBounds = new CollidableVo();
			duckingBounds = new CollidableVo();
			_stateTransition = new CrossfadeStateTransition( 0.5 );
			resetInGameId();
		}
		
		public function resetInGameId():void {
			_inGameId = -1;
		}
		
		public function getDistanceFromPreviousPosition():Number {
			return position.subtract( prevPosition ).length;
		}
		
		public function updateMeshPosition():void {
			prevPosition.x = mesh.x;
			prevPosition.y = mesh.y;
			prevPosition.z = mesh.z;
			mesh.x = position.x;
			mesh.y = position.y;
			mesh.z = position.z;
			// Rotate.
			var diff:Vector3D = prevPosition.subtract( position );
			var atan:Number = Math.atan2( diff.x, diff.z );
			if ( atan == 0 ) atan = Math.PI;
			var angle:Number = atan * 180 / Math.PI;
			_targetRotation = angle - 180;
			var rotDiff:Number = _targetRotation - mesh.rotationY;
			if ( rotDiff < 180 ) {
				mesh.rotationY += ( rotDiff ) * .4;
			} else {
				mesh.rotationY -= ( 360 - ( rotDiff ) ) * .4;
			}
			// Keep animation stationary within container.
			_character.mesh.x = _character.mesh.y = _character.mesh.z = 0;
		}
		
		public function run():void {
			_animator.playbackSpeed = _character.getSpeedFor( CharacterAnimations.RUN );
			_animator.play( CharacterAnimations.RUN, _stateTransition );
		}
		
		public function jump():int {
			playSingleAnimation( CharacterAnimations.JUMP );
			isOnTheGround = false;
			_jumps++;
			return _jumps - 1;
		}
		
		private function playSingleAnimation( id:String ):void {
			if ( _animator.animationSet.hasState( id ) ) {
				_animator.playbackSpeed = _character.getSpeedFor( id );
				( _animator.animationSet.getState( id ) as SkeletonAnimationState ).addEventListener( AnimationStateEvent.PLAYBACK_COMPLETE, onJumpComplete );
				_animator.play( id, _stateTransition );
			}
		}
		
		private function onJumpComplete( event:AnimationStateEvent ):void {
			run();
		}
		
		public function setCharacter( character:CharacterVo ):void {
			if ( _character ) {
				mesh.removeChild( _character.mesh );
			}
			_character = character;
			_animator = _character.animator;
			mesh.addChild( _character.mesh );
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
