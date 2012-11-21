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
		protected var _listItemHeight:Number = 20;
		protected var _scrollbar:VerticalScrollBar;
		protected var _selectedIndex:int = -1;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function ChatList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null)
		{
			if ( items != null ) {
				_items = items;
			} else {
				_items = new Array();
			}
			
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			addEventListener(Event.RESIZE, onResize);
			makeListItems();
			fillItems();
			
			// Background.
			_bg = new Background();
			addChild( _bg );
			
			_itemHolder = new Sprite();
			_scrollbar = new VerticalScrollBar(this, 0, 0, onScroll);
			_scrollbar.setSliderParams(0, 0, 0);
	
			super(parent, xpos, ypos);
		}
		
		/**
		 * Creates all the list items based on data.
		 */
		protected function makeListItems():void
		{
			var item:ChatListItem;
			while(_itemHolder.numChildren > 0)
			{
				item = ChatListItem(_itemHolder.getChildAt(0));
				item.removeEventListener(MouseEvent.CLICK, onSelect);
				_itemHolder.removeChildAt(0);
			}
			
			var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
			numItems = Math.max(numItems, 1);
			for(var i:int = 0; i < numItems; i++)
			{
				
				item = new ChatListItem(_itemHolder, 0, i * _listItemHeight);
				item.setSize(width, _listItemHeight);
				item.addEventListener(MouseEvent.CLICK, onSelect);
			}
		}
		
		protected function fillItems():void
		{
			var offset:int = _scrollbar.value;
			var numItems:int = Math.ceil(_height / _listItemHeight);
			numItems = Math.min(numItems, _items.length);
			for(var i:int = 0; i < numItems; i++)
			{
				var item:ChatListItem = _itemHolder.getChildAt(i) as ChatListItem;
				if(offset + i < _items.length)
				{
					item.data = _items[offset + i];
				}
				else
				{
					item.data = "";
				}
				
				if(offset + i == _selectedIndex)
				{
					item.selected = true;
				}
				else
				{
					item.selected = false;
				}
			}
		}
		
		/**
		 * If the selected item is not in view, scrolls the list to make the selected item appear in the view.
		 */
		protected function scrollToSelection():void
		{
			var numItems:int = Math.ceil(_height / _listItemHeight);
			if(_selectedIndex != -1)
			{
				if(_scrollbar.value > _selectedIndex)
				{
					//                    _scrollbar.value = _selectedIndex;
				}
				else if(_scrollbar.value + numItems < _selectedIndex)
				{
					_scrollbar.value = _selectedIndex - numItems + 1;
				}
			}
			else
			{
				_scrollbar.value = 0;
			}
			fillItems();
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
			
			_selectedIndex = Math.min(_selectedIndex, _items.length - 1);
			
			
			// panel
		//	_panel.setSize(_width, _height);
		//	_panel.color = _defaultColor;
		//	_panel.draw();
			
			// scrollbar
			_scrollbar.x = _width - 10;
			var contentHeight:Number = _items.length * _listItemHeight;
			_scrollbar.setThumbPercent(_height / contentHeight); 
			var pageSize:Number = Math.floor(_height / _listItemHeight);
			_scrollbar.maximum = Math.max(0, _items.length - pageSize);
			_scrollbar.pageSize = pageSize;
			_scrollbar.height = _height;
			_scrollbar.draw();
			scrollToSelection();
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_items.push(item);
			invalidate();
			makeListItems();
			fillItems();
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			index = Math.max(0, index);
			index = Math.min(_items.length, index);
			_items.splice(index, 0, item);
			invalidate();
			fillItems();
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
			removeItemAt(index);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			if(index < 0 || index >= _items.length) return;
			_items.splice(index, 1);
			invalidate();
			makeListItems();
			fillItems();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_items.length = 0;
			invalidate();
			makeListItems();
			fillItems();
		}
		
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when a user selects an item in the list.
		 */
		protected function onSelect(event:Event):void
		{
			if(! (event.target is ChatListItem)) return;
			
			var offset:int = _scrollbar.value;
			
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) _selectedIndex = i + offset;
				ChatListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			ChatListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		/**
		 * Called when the user scrolls the scroll bar.
		 */
		protected function onScroll(event:Event):void
		{
			fillItems();
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
			fillItems();
		}
		
		protected function onResize(event:Event):void
		{
			makeListItems();
			fillItems();
		}
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			if(value >= 0 && value < _items.length)
			{
				_selectedIndex = value;
				//				_scrollbar.value = _selectedIndex;
			}
			else
			{
				_selectedIndex = -1;
			}
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
		}
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
			//			if(index != -1)
			//			{
			selectedIndex = index;
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
			//			}
		}
		public function get selectedItem():Object
		{
			if(_selectedIndex >= 0 && _selectedIndex < _items.length)
			{
				return _items[_selectedIndex];
			}
			return null;
		}
		
		/**
		 * Sets / gets the list of items to be shown.
		 */
		public function set items(value:Array):void
		{
			_items = value;
			invalidate();
		}
		public function get items():Array
		{
			return _items;
		}
		
		/**
		 * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
		 */
		public function set autoHideScrollBar(value:Boolean):void
		{
			_scrollbar.autoHide = value;
		}
		public function get autoHideScrollBar():Boolean
		{
			return _scrollbar.autoHide;
		}
		
	}
}