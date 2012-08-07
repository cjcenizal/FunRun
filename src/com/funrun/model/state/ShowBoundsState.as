package com.funrun.model.state
{
	public class ShowBoundsState
	{
		
		private var _showBounds:Boolean;
		
		public function ShowBoundsState( showBounds:Boolean )
		{
			_showBounds = showBounds;
		}
		
		public function get showBounds():Boolean {
			return _showBounds;
		}
	}
}