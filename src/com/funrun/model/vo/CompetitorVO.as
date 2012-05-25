package com.funrun.model.vo {

	import away3d.entities.Mesh;

	import flash.geom.Vector3D;

	public class CompetitorVO {

		public var id:String;
		public var mesh:Mesh;
		public var position:Vector3D;
		public var velocity:Vector3D;
		public var isDead:Boolean;
		public var isDucking:Boolean;

		public function CompetitorVO( id:String, mesh:Mesh, position:Vector3D, velocity:Vector3D, isDead:Boolean, isDucking:Boolean ) {
			this.id = id;
			this.mesh = mesh;
			this.position = position;
			this.velocity = velocity;
			this.isDead = isDead;
			this.isDucking = isDucking;
		}
	}
}
