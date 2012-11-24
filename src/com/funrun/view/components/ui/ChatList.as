package com.funrun.view.components.ui
{
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class ChatList extends AbstractComponent
	{
		
		[Embed (source="embed/lobby_chat_bg.png" )]
		private var Background:Class;
		
		private var _bg:Bitmap;
		protected var _items:Array;
		protected var _itemHolder:Sprite;
		private var _mask:Sprite;
		protected var _listItemHeight:Number = 42;
		protected var _scrollbar:VerticalScrollBar;
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function ChatList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null)
		{
			if(items != null)
			{
				_items = items;
			}
			else
			{
				_items = new Array();
			}
			super(parent, xpos, ypos);
			
			_bg = new Background();
			_bg.y = -18;
			addChild( _bg );
	
			_itemHolder = new Sprite();
			addChild(_itemHolder);
			
			_mask = new Sprite();
			addChild(_mask);
			_mask.graphics.clear();
			_mask.graphics.beginFill( 0xff0000, .5 );
			_mask.graphics.drawRect( 0, 0, _bg.width, 448 );
			_mask.graphics.endFill();
			_itemHolder.mask = _mask;
			
			_scrollbar = new VerticalScrollBar(this, 0, 0, onScroll);
			_scrollbar.setSize( 15, _mask.height );
			
			setSize( 456, 495 );
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			for ( var i:int = 0; i < 100; i++ ) {
				addChat("test");
			}
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw() : void
		{
			super.draw();
			
			// scrollbar
			_scrollbar.x = 495;
			var contentHeight:Number = _items.length * _listItemHeight;
			_scrollbar.sliderPct = _height / contentHeight; 
			var pageSize:Number = Math.floor(_height / _listItemHeight);
		//	_scrollbar.maximum = Math.max(0, _items.length - pageSize);
		//	_scrollbar.pageSize = pageSize;
			_scrollbar.draw();
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addChat(message:String):void
		{
			var yPos:Number = ( _items.length > 0 ) ? _items[ _items.length - 1 ].y + _items[ _items.length - 1 ].height + 10 : 0;
			var item:ChatListItem = new ChatListItem( _itemHolder, 10, yPos, message, width - 50 );
			item.setSize(width - 40, _listItemHeight);
			item.draw();
			_items.push(item);
			invalidate();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			for ( var i:int = 0; i < _items.length; i++ ) {
				_itemHolder.removeChild( _items[ i ] );
			}
			_items = [];
			invalidate();
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when the user scrolls the scroll bar.
		 */
		protected function onScroll(event:Event):void
		{
			_itemHolder.y = _scrollbar.percent * ( _mask.height - _itemHolder.height );
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			//_scrollbar.value -= event.delta;
		}
	}
}