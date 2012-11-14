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
		public var skeleton:Skeleton;
		private var _mesh:Mesh;
		private var _scale:Number;
		private var _material:TextureMaterial;
		private var _speeds:Dictionary;
		private var _animationStatesBuffer:Array;
		
		public function CharacterVo( id:String, scale:Number )
		{
			this.id = id;
			_scale = scale;
			_material = new TextureMaterial();
			_speeds = new Dictionary();
		}
		
		public function storeAnimationSet( animationSet:SkeletonAnimationSet ):void {
			this.animationSet = animationSet;
			if ( _animationStatesBuffer ) {
				for ( var i:int = _animationStatesBuffer.length - 1; i >= 0; i-- ) {
					animationSet.addState( _animationStatesBuffer[ i ].namespace, _animationStatesBuffer[ i ].state );
					_animationStatesBuffer.pop();
				}
			}
		}
		
		public function storeSkeleton( skeleton:Skeleton ):void {
			this.skeleton = skeleton;
		}
		
		public function storeMesh( mesh:Mesh ):void {
			_mesh = mesh;
			_mesh.scaleX = _mesh.scaleY = _mesh.scaleZ = _scale;
			_mesh.material = _material;
		}
		
		public function storeAnimationState( state:SkeletonAnimationState, namespace:String, looping:Boolean, speed:Number ):void {
			if ( animationSet ) {
				animationSet.addState( namespace, state );
			} else {
				_animationStatesBuffer = _animationStatesBuffer || [];
				_animationStatesBuffer.push( { namespace: namespace, state: state } );
			}
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
			var mesh:Mesh = _mesh.clone() as Mesh;
			return mesh;
		}
		
		public function getAnimator():SkeletonAnimator {
			return new SkeletonAnimator( this.animationSet, skeleton ); 
		}
	}
}