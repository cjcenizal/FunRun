package com.funrun.view.components.ui
{
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.ImageButton;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[Event(name="change", type="flash.events.Event")]
	public class VerticalScrollBar extends AbstractComponent
	{
		
		[Embed (source="embed/arrow_button.jpg" )]
		private var ArrowButton:Class;
		
		[Embed (source="embed/arrow_button_hover.jpg" )]
		private var ArrowButtonHover:Class;
		
		protected var _upButton:ImageButton;
		protected var _downButton:ImageButton;
		private var _bg:Sprite;
		private var _sliderBar:Sprite;
		private var _sliderPct:Number = 0;
		private var _sliderHeight:Number = 10;
		private var _pct:Number = 0;
		
		/**
		 * Constructor
		 * @param orientation Whether this is a vertical or horizontal slider.
		 * @param parent The parent DisplayObjectContainer on which to add this Slider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function VerticalScrollBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function = null)
		{
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
			
			_bg = new Sprite();
			addChild( _bg );
			_bg.addEventListener( MouseEvent.MOUSE_DOWN, onBgMouseDown );
			_bg.addEventListener( MouseEvent.MOUSE_UP, onBgMouseUp );
			
			var upArrowButton:Bitmap = new ArrowButton();
			var upArrowButtonHover:Bitmap = new ArrowButtonHover();
			
			_upButton = new ImageButton(this, 0, 0, onUpClick );
			_upButton.setImages( upArrowButton, upArrowButtonHover, false );
			
			var downArrowButton:Bitmap = new ArrowButton();
			var downArrowButtonHover:Bitmap = new ArrowButtonHover();
			downArrowButton.scaleY = downArrowButtonHover.scaleY = -1;
			
			_downButton = new ImageButton(this, 0, 0, onDownClick);
			_downButton.setImages( downArrowButton, downArrowButtonHover, false );
			
			_sliderBar = new Sprite();
			addChild( _sliderBar );
			_sliderBar.y = _upButton.height;
			_sliderBar.addEventListener( MouseEvent.MOUSE_DOWN, onSliderMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
			_bg.y = _upButton.y + _upButton.height;
			
			setSize( 15, 300 );
		}
		
		override public function draw():void {
			super.draw();
			var g:Graphics;
			
			g = _bg.graphics;
			g.clear();
			g.beginFill( 0, .5 );
			g.drawRect( 0, 0, _width, _height - _bg.y - _downButton.height );
			g.endFill();
			
			_sliderHeight = _sliderPct * _bg.height;
			
			g = _sliderBar.graphics;
			g.clear();
			g.lineStyle( 1, 0xffe657 );
			g.beginFill( 0xffa424 );
			g.drawRect( 0, 0, _width, _sliderHeight );
			g.endFill();
			
			_downButton.y = _height - _downButton.height;
		}
		
		private function onUpClick( e:MouseEvent ):void {
			pageUp();
		}
		
		private function onDownClick( e:MouseEvent ):void {
			pageDown();
		}
		
		private function onSliderMouseDown( e:MouseEvent ):void {
			_sliderBar.startDrag( false, new Rectangle( 0, _bg.y, 0, _bg.height - _sliderBar.height ) );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		private function onMouseUp( e:MouseEvent ):void {
			_sliderBar.stopDrag();
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		private function onMove( e:MouseEvent ):void {
			updateSlider();
		}
		
		private function onBgMouseDown( e:MouseEvent ):void {
			if ( _bg.mouseY < _sliderBar.y - _bg.y ) {
				pageUp();
			} else if ( _bg.mouseY > _sliderBar.y - _bg.y + _sliderBar.height ) {
				pageDown();
			}
		}
		
		private function onBgMouseUp( e:MouseEvent ):void {
			
		}
		
		private function pageUp():void {
			_sliderBar.y -= 10;
			updateSlider();
		}
		
		private function pageDown():void {
			_sliderBar.y += 10;
			updateSlider();
		}
		
		private function updateSlider():void {
			if ( _sliderBar.y < _bg.y ) _sliderBar.y = _bg.y;
			else if ( _sliderBar.y > _bg.y + _bg.height - _sliderBar.height ) _sliderBar.y = _bg.y + _bg.height - _sliderBar.height;
			_pct = ( _sliderBar.y - _bg.y ) / ( _bg.height - _sliderBar.height );
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		public function set sliderPct( pct:Number ):void {
			if ( pct == Infinity ) pct = 1;
			else if ( pct < 0 ) pct = 0;
			else if ( pct > 1 ) pct = 1;
			_sliderPct = pct;
			draw();
		}
		
		public function get percent():Number {
			return _pct;
		}
	}
}