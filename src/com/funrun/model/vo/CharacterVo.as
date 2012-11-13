package com.funrun.model.vo
{
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.data.Skeleton;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.utils.Cast;
	
	import com.funrun.model.constants.CharacterMaps;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	public class CharacterVo
	{
		
		public var id:String;
		public var animationSet:SkeletonAnimationSet;
		public var animator:SkeletonAnimator;
		public var skeleton:Skeleton;
		private var _mesh:Mesh;
		private var _scale:Number;
		private var _material:TextureMaterial;
		private var _speeds:Dictionary;
		
		public function CharacterVo( id:String, scale:Number )
		{
			this.id = id;
			_scale = scale;
			_material = new TextureMaterial();
			_speeds = new Dictionary();
		}
		
		public function init( animationSet:SkeletonAnimationSet ):void {
			this.animationSet = animationSet;
			animator = new SkeletonAnimator( this.animationSet, skeleton );
			if ( _mesh ) _mesh.animator = animator;
		}
		
		public function storeSkeleton( skeleton:Skeleton ):void {
			this.skeleton = skeleton;
		}
		
		public function storeMesh( mesh:Mesh ):void {
			_mesh = mesh;
			_mesh.scaleX = _mesh.scaleY = _mesh.scaleZ = _scale;
			_mesh.material = _material;
			if ( this.animator ) _mesh.animator = this.animator;
		}
		
		public function storeAnimationState( state:SkeletonAnimationState, namespace:String, looping:Boolean, speed:Number ):void {
			this.animationSet.addState( namespace, state );
			state.looping = looping;
			_speeds[ namespace ] = speed;
		}
		
		public function getSpeedFor( stateName:String ):Number {
			return _speeds[ stateName ];
		}
		
		public function storeMap( mapId:String, data:BitmapData ):void {
			switch ( mapId ) {
				case CharacterMaps.DIFFUSE:
					_material.texture = Cast.bitmapTexture( data );
					break;
				case CharacterMaps.NORMALS:
					_material.normalMap = Cast.bitmapTexture( data );
					break;
				case CharacterMaps.SPECULAR:
					_material.specularMap = Cast.bitmapTexture( data );
					break;
			}
		}
		
		public function getMeshClone():Mesh {
			return _mesh.clone() as Mesh;
		}
	}
}