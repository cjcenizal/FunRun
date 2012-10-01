package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.StoreObstacleVo;
	
	import org.osflash.signals.Signal;
	
	public class StoreObstacleRequest extends Signal
	{
		public function StoreObstacleRequest()
		{
			super( StoreObstacleVo );
		}
	}
}