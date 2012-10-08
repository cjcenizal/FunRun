
package com.funrun.controller.signals.vo
{
	public class AddToReadyListVo
	{
		public var id:int;
		public var name:String;
		public var isReady:Boolean;
		
		public function AddToReadyListVo( id:int, name:String, isReady:Boolean )
		{
			this.id = id;
			this.name = name;
			this.isReady = isReady;
		}
	}
}