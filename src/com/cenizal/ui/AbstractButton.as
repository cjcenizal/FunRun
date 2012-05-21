package com.cenizal.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class AbstractButton extends AbstractComponent {
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
		 * @param x The x position to place this component.
		 * @param y The y position to place this component.
		 * @param label The string to use for the initial label of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function AbstractButton( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, defaultHandler:Function = null ) {
			super( parent, x, y );
			if ( defaultHandler != null ) {
				addEventListener( MouseEvent.CLICK, defaultHandler );
			}
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void {
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize( 100, 20 );
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void {
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void {
			super.draw();
		}
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver( e:MouseEvent ):void {
			_over = true;
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut( e:MouseEvent ):void {
			_over = false;
			removeEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseDown( e:MouseEvent ):void {
			_down = true;
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseUp( e:MouseEvent ):void {
			if ( _toggle && _over ) {
				_selected = !_selected;
			}
			_down = _selected;
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		public function set selected( value:Boolean ):void {
			if ( !_toggle ) {
				value = false;
			}
			
			_selected = value;
			_down = _selected;
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set toggle( value:Boolean ):void {
			_toggle = value;
		}
		
		public function get toggle():Boolean {
			return _toggle;
		}
	
	}
}
