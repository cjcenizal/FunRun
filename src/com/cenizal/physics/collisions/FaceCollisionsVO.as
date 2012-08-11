package com.cenizal.physics.collisions
{
	public class FaceCollisionsVO
	{
		
		private var _faces:Array;
		private var _amounts:Array;
		
		public function FaceCollisionsVO( faces:Array, amounts:Array ) {
			_faces = faces;
			_amounts = amounts;
		}
		
		public function get count():int {
			return _faces.length;
		}
		
		public function getAt( index:int ):String {
			return _faces[ index ];
		}
		
		public function getAmount( index:int ):Number {
			return _amounts[ index ];
		}
		
		public function contains( face:String ):Boolean {
			return _faces.indexOf( face ) >= 0;
		}
		
		public function toString():String {
			return _faces.toString() + " (" + _amounts.toString() + ")";
		}
	}
}