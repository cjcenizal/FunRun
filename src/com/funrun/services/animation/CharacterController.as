package com.funrun.services.animation
{
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.transitions.CrossfadeStateTransition;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.AnimatorEvent;
	
	import com.funrun.model.constants.CharacterAnimations;
	import com.funrun.model.vo.CharacterVo;

	public class CharacterController
	{
		private var _character:CharacterVo;
		private var _animator:SkeletonAnimator;
		private var _stateTransition:CrossfadeStateTransition;
		
		public function CharacterController()
		{
			_stateTransition = new CrossfadeStateTransition( 0.5 );
		}
		
		public function updateLockedPosition():void {
			// Keep animation stationary within container.
			_character.mesh.x = _character.mesh.y = _character.mesh.z = 0;
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
		
		public function setCharacter( character:CharacterVo ):void {
			_character = character;
			_animator = _character.animator;
		}
		
		public function get character():CharacterVo {
			return _character;
		}
		
		public function get mesh():Mesh {
			return _character.mesh;
		}
	}
}