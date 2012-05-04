package com.funrun.game.view {
	
	import away3d.bounds.BoundingVolumeBase;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	public class Obstacle extends ObjectContainer3D {
		public var id:String;
		
		private var _geos:Array;
		
		private var _prevZ:Number = 0;
		
		public function Obstacle( id:String ) {
			super();
			this.id = id;
			_geos = [];
		}
		
		public function move( amount:Number ):void {
			_prevZ = z;
			z += amount;
		}
		
		public function addGeo( geo:Mesh ):void {
			_geos.push( geo );
			addChild( geo );
		}
		
		public function getGeo():Mesh {
			return _geos[ 0 ]; // test
		}
		
		public function destroy():void {
			this.parent.removeChild( this );
			var len:int = _geos.length;
			var geo:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				geo = _geos[ i ];
				removeChild( geo );
				_geos[ i ] - null;
			}
			_geos = null;
		}
		
		public function get prevZ():Number {
			return _prevZ;
		}
		
		public function collide( object:Mesh ):Boolean {
			if ( Math.abs( this.z - object.z ) < 300 ) {
				var pos:Vector3D;// = this.inverseSceneTransform.transformVector( object.position );
				var len:int = _geos.length;
				var collides:Boolean = false;
				var geo:Mesh;
				for ( var i:int = 0; i < len; i++ ) {
					geo = _geos[ i ];
					pos = geo.inverseSceneTransform.transformVector( object.position );
					collides = aabbTest( pos, object.bounds, geo.bounds );
					if ( collides ) {
						return true;
					}
				}
			}
			return false;
		}
		
		private function aabbTest( pos:Vector3D, boundsA:BoundingVolumeBase, boundsB:BoundingVolumeBase ):Boolean {
			if ( pos.x + boundsA.min.x > boundsB.max.x || boundsB.min.x > pos.x + boundsA.max.x ) {
				return false;
			}
			if ( pos.y + boundsA.min.y > boundsB.max.y || boundsB.min.y > pos.y + boundsA.max.y ) {
				return false;
			}
			if ( pos.z + boundsA.min.z > boundsB.max.z || boundsB.min.z > pos.z + boundsA.max.z ) {
				return false;
			}
			return true;
		}
	}
}
