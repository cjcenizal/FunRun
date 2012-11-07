package com.funrun.model.vo
{
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.data.Skeleton;
	import away3d.entities.Mesh;

	public class CharacterVo
	{
		
		public var id:String;
		public var animationSet:SkeletonAnimationSet;
		public var animator:SkeletonAnimator;
		public var skeleton:Skeleton;
		public var mesh:Mesh;
		
		public function CharacterVo( id:String )
		{
			this.id = id;
		}
		
		public function init( animationSet:SkeletonAnimationSet ):void {
			this.animationSet = animationSet;
			animator = new SkeletonAnimator( this.animationSet, skeleton );
		}
		
		public function storeSkeleton( skeleton:Skeleton ):void {
			this.skeleton = skeleton;
		}
		
		public function storeMesh( mesh:Mesh ):void {
			this.mesh = mesh;
		}
		
		public function storeAnimationState( state:SkeletonAnimationState, namespace:String, looping:Boolean ):void {
			this.animationSet.addState( namespace, state );
			state.looping = looping;
		}
	}
}