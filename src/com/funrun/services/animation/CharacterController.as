package com.funrun.services.animation
{
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.transitions.CrossfadeStateTransition;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	
	import com.funrun.model.constants.CharacterAnimations;
	import com.funrun.model.vo.CharacterVo;
	
	import flash.geom.Vector3D;

	public class CharacterController
	{
		
		// Model animation.
		private var _mesh:Mesh;
		private var _character:CharacterVo;
		private var _animator:SkeletonAnimator;
		private var _stateTransition:CrossfadeStateTransition;
		
		// Physics.
		public var position:Vector3D;
		public var prevPosition:Vector3D;
		public var velocity:Vector3D;
		private var _targetRotation:Number = 0;
		
		public function CharacterController()
		{
			_stateTransition = new CrossfadeStateTransition( 0.5 );
			velocity = new Vector3D();
			position = new Vector3D();
			prevPosition = new Vector3D();
			_mesh = new Mesh( new Geometry() );
		}
		
		public function getDistanceFromPreviousPosition():Number {
			return position.subtract( prevPosition ).length;
		}
		
		public function updatePosition():void {
			prevPosition.x = _mesh.x;
			prevPosition.y = _mesh.y;
			prevPosition.z = _mesh.z;
			_mesh.x = position.x;
			_mesh.y = position.y;
			_mesh.z = position.z;
			// Rotate.
			var diff:Vector3D = prevPosition.subtract( position );
			var atan:Number = Math.atan2( diff.x, diff.z );
			if ( atan == 0 ) atan = Math.PI;
			var angle:Number = atan * 180 / Math.PI;
			_targetRotation = angle - 180;
			var rotDiff:Number = _targetRotation - _mesh.rotationY;
			if ( rotDiff < 180 ) {
				_mesh.rotationY += ( rotDiff ) * .4;
			} else {
				_mesh.rotationY -= ( 360 - ( rotDiff ) ) * .4;
			}
			// Keep animation stationary within container.
			_character.mesh.x = _character.mesh.y = _character.mesh.z = 0;
		}
		
		public function setCharacter( character:CharacterVo ):void {
			if ( characterMesh ) {
				_mesh.removeChild( characterMesh );
			}
			_character = character;
			_animator = _character.animator;
			_mesh.addChild( characterMesh );
		}
		
		public function run():void {
			_animator.playbackSpeed = _character.getSpeedFor( CharacterAnimations.RUN );
			_animator.play( CharacterAnimations.RUN, _stateTransition );
		}
		
		public function jump():void {
			playSingleAnimation( CharacterAnimations.JUMP );
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
		
		public function get character():CharacterVo {
			return _character;
		}
		
		public function get characterMesh():Mesh {
			return _character.mesh;
		}
		
		public function get mesh():Mesh {
			return _mesh;
		}
	}
}