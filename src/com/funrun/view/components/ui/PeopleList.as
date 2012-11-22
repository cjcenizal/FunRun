package com.funrun.view.components.ui
{
	import com.bit101.components.VScrollBar;
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.view.components.LobbyPerson;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class PeopleList extends AbstractComponent
	{
		private var _title:AbstractLabel;
		private var _count:AbstractLabel;
		protected var _items:Array;
		protected var _itemHolder:Sprite;
		private var _mask:Sprite;
		protected var _listItemHeight:Number = 42;
		protected var _scrollbar:VScrollBar;
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function PeopleList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null)
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
			
			_width = 243;
			_height = 448;
			
			_title = new AbstractLabel( this, 0, 0, "Lobby", 22, 0xffdf2c );
			_count = new AbstractLabel( this, 0, 0, "Peeps", 16, 0xffdf2c );
			var g:Graphics = this.graphics;
			g.lineStyle( 1, 0xffdf2c );
			g.moveTo( 0, 30 );
			g.lineTo( _width, 30 );
			g.endFill();
			
			_itemHolder = new Sprite();
			addChild(_itemHolder);
			
			_mask = new Sprite();
			addChild(_mask);
			_itemHolder.y = _mask.y = 40;
			_mask.graphics.clear();
			_mask.graphics.beginFill( 0xff0000, .5 );
			_mask.graphics.drawRect( 0, 0, 300, _height - _mask.y );
			_mask.graphics.endFill();
			_itemHolder.mask = _mask;
			
			_scrollbar = new VScrollBar(this, 0, 0, onScroll);
			_scrollbar.setSliderParams(0, 0, 0);
			_scrollbar.y = _mask.y;
			
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			for ( var i:int = 0; i < 30; i++ ) {
				addPerson(new LobbyPerson(i.toString(), "test"));
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
			
			if ( _items.length > 1 ) {
				_count.text = _items.length + " peeps";
			} else {
				_count.text = "No one's here.";
			}
			_count.draw();
			_count.x = _width - _count.width;
			_count.y = 6;
			
			// scrollbar
			_scrollbar.x = _width - 10;
			var contentHeight:Number = _items.length * _listItemHeight;
			_scrollbar.setThumbPercent(_height / contentHeight); 
			var pageSize:Number = Math.floor(_height / _listItemHeight);
			_scrollbar.maximum = Math.max(0, _items.length - pageSize);
			_scrollbar.pageSize = pageSize;
			_scrollbar.height = _mask.height;
			_scrollbar.draw();
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addPerson(person:LobbyPerson):void
		{
			var yPos:Number = ( _items.length > 0 ) ? _items[ _items.length - 1 ].y + _items[ _items.length - 1 ].height + 10 : 0;
			var item:PeopleListItem = new PeopleListItem( _itemHolder, 0, yPos, person.name, width - 50 );
			item.setSize(width - 40, _listItemHeight);
			item.draw();
			_items.push(item);
			invalidate();
		}
		
		public function removePerson(person:LobbyPerson):void {
			
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
			var pct:Number = _scrollbar.value / ( _scrollbar.maximum - _scrollbar.minimum );
			_itemHolder.y = pct * ( _mask.height - _itemHolder.height ) + _mask.y;
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		
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