package com.funrun.controller.signals
{
	import com.funrun.model.vo.StoreObstacleVo;
	
	import org.osflash.signals.Signal;
	
	public class StoreObstacleRequest extends Signal
	{
		public function StoreObstacleRequest()
		{
			super( StoreObstacleVo );
		}
	}
}