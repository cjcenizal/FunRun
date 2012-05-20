package com.cenizal.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class AbstractComponent extends Sprite {
		
		public static const EVENT_DRAW:String = "AbstractComponentEvent.DRAW";
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _enabled:Boolean = true;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this component.
		 * @param x The x position to place this component.
		 * @param y The y position to place this component.
		 */
		public function AbstractComponent( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super();
			move( x, y );
			if ( parent ) {
				parent.addChild( this );
			}
		}
		
		/**
		 * Initilizes the component.
		 */
		protected function init():void {
			addChildren();
			invalidate();
		}
		
		/**
		 * Overriden in subclasses to create child display objects.
		 */
		protected function addChildren():void {
		
		}
		
		/**
		 * Marks the component to be redrawn on the next frame.
		 */
		protected function invalidate():void {
			if ( stage ) {
				stage.addEventListener( Event.ENTER_FRAME, onInvalidate );
			}
		}
		
		/**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
		public function move( xpos:Number, ypos:Number ):void {
			x = Math.round( xpos );
			y = Math.round( ypos );
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		public function setSize( w:Number, h:Number ):void {
			_width = w;
			_height = h;
			dispatchEvent( new Event( Event.RESIZE ) );
			invalidate();
		}
		
		/**
		 * Abstract draw function.
		 */
		public function draw():void {
			if ( stage ) {
				stage.removeEventListener( Event.ENTER_FRAME, onInvalidate );
			}
			dispatchEvent( new Event( EVENT_DRAW ) );
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called one frame after invalidate is called.
		 */
		protected function onInvalidate( event:Event ):void {
			draw();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets/gets the width of the component.
		 */
		override public function set width( w:Number ):void {
			_width = w;
			invalidate();
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		override public function get width():Number {
			return _width;
		}
		
		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height( h:Number ):void {
			_height = h;
			invalidate();
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		override public function get height():Number {
			return _height;
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public function set enabled( value:Boolean ):void {
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
	}
}
