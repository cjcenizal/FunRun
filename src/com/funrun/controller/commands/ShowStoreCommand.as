package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawItemRequest;
	import com.funrun.controller.signals.ToggleStoreRequest;
	import com.funrun.model.AccountModel;
	import com.funrun.model.StoreModel;
	import com.funrun.controller.signals.vo.DrawItemVo;
	import com.funrun.model.vo.VirtualGoodCategoryVo;
	import com.funrun.model.vo.VirtualGoodVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowStoreCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var accountModel:AccountModel;
		
		[Inject]
		public var storeModel:StoreModel;
		
		// Commands.
		
		[Inject]
		public var toggleStoreRequest:ToggleStoreRequest;
		
		[Inject]
		public var drawItemRequest:DrawItemRequest;
		
		override public function execute():void {
			
			// Show the store UI.
			toggleStoreRequest.dispatch( true );
			
			// Load the store UI with all categories, items, and info on whether it's worn/owned.
			var category:VirtualGoodCategoryVo, item:VirtualGoodVo;
			for ( var i:int = 0; i < storeModel.numCategories; i++ ) {
				category = storeModel.getCategoryAt( i );
				for ( var j:int = 0; j < category.count; j++ ) {
					item = category.getAt( j );
					drawItemRequest.dispatch( new DrawItemVo(
						category,
						item,
						accountModel.owns( item.id ),
						accountModel.wears( item.id ) ) );
				}
			}
			
		}
	}
}