package com.funrun.view.components.ui
{
	import com.bit101.components.ScrollBar;
	import com.bit101.components.Slider;
	
	import flash.display.DisplayObjectContainer;
	
	public class VerticalScrollBar extends ScrollBar
	{
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ScrollBar.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function VerticalScrollBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function=null)
		{
			super(Slider.VERTICAL, parent, xpos, ypos, defaultHandler);
		}
	}
}