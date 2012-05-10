package com.funrun.game.controller.events
{
	import flash.events.Event;
	
	public class RenderSceneRequest extends Event
	{
		public static const RENDER_SCENE_REQUESTED:String = "RenderSceneRequest.RENDER_SCENE_REQUESTED";
		
		public function RenderSceneRequest(type:String)
		{
			super(type);
		}
	}
}