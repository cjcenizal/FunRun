package com.funrun.view.components.ui
{
	import com.bit101.components.Label;
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class ChatListItem extends AbstractComponent
	{
		protected var _message:String;
		protected var _label:AbstractLabel;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ListItem.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param data The string to display as a label or object with a label property.
		 */
		public function ChatListItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, message:String = null, itemWidth:int = 100)
		{
			_message = message;
			super(parent, xpos, ypos);
			
			_label = new AbstractLabel(this, 0, 0, null, 12, 0xffffff );
			_label.wordWrap = true;
			_label.maxWidth = itemWidth - 40;
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw():void {
			super.draw();
			_label.text = _message;
			_label.draw();
			_height = _label.y + _label.height;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets/gets the string that appears in this item.
		 */
		public function set message(value:String):void
		{
			_message = value;
			invalidate();
		}
		public function get message():String
		{
			return _message;
		}
	}
}