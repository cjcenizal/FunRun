package com.funrun.controller.signals.vo
{
	import com.funrun.model.vo.VirtualGoodCategoryVo;
	import com.funrun.model.vo.VirtualGoodVo;

	public class DrawItemVo
	{
		
		public var category:VirtualGoodCategoryVo;
		public var item:VirtualGoodVo;
		public var isOwned:Boolean;
		public var isWorn:Boolean;
		
		public function DrawItemVo( category:VirtualGoodCategoryVo, item:VirtualGoodVo, isOwned:Boolean, isWorn:Boolean )
		{
			this.category = category;
			this.item = item;
			this.isOwned = isOwned;
			this.isWorn = isWorn;
		}
	}
}