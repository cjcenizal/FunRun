package com.funrun.model
{
	import com.funrun.model.vo.VirtualGoodCategoryVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class StoreModel extends Actor
	{
		public function StoreModel()
		{
			super();
		}
		
		public function get numCategories():int {
			return 0;
		}
		
		public function getCategoryAt( index:int ):VirtualGoodCategoryVo {
			return null;
		}
	}
}