package com.cenizal.physics.collisions
{
	public class FaceCollisionsVO
	{
		
		public var faces:Array;
		public var xPenetration:Number;
		public var yPenetration:Number;
		public var zPenetration:Number;
		
		public var axes:Array;
		
		public function FaceCollisionsVO( faces:Array, xPenetration:Number, yPenetration:Number, zPenetration:Number )
		{
			this.faces = faces;
			this.xPenetration = xPenetration;
			this.yPenetration = yPenetration;
			this.zPenetration = zPenetration;
			
			axes = [
				{ "dir" : Axis.X, "amount" : yPenetration + zPenetration },
				{ "dir" : Axis.Y, "amount" : xPenetration + zPenetration },
				{ "dir" : Axis.Z, "amount" : xPenetration + yPenetration } ];
			axes.sortOn( "amount", Array.NUMERIC | Array.DESCENDING );
			for ( var i:int = 0; i < axes.length; i++ ) {
				axes[ i ] = axes[ i ][ "dir" ];
			}
		}
		
		public function contains( face:String ):Boolean {
			return this.faces.indexOf( face ) >= 0;
		}
		
		public function toString():String {
			return this.faces.toString();
		}
	}
}