package com.funrun.controller.signals
{
	import com.funrun.model.vo.VirtualGoodCategoryVo;
	import com.funrun.model.vo.VirtualGoodVo;
	
	import org.osflash.signals.Signal;
	
	public class DrawItemRequest extends Signal
	{
		public function DrawItemRequest()
		{
			super( VirtualGoodCategoryVo, VirtualGoodVo );
		}
	}
}