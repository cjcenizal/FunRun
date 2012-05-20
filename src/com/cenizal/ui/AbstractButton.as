package com.cenizal.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
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
		public function PushButton( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, label:String = "", defaultHandler:Function = null ) {
			super( parent, x, y );
			if ( defaultHandler != null ) {
				addEventListener( MouseEvent.CLICK, defaultHandler );
			}
			this.label = label;
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
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseGoDown );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void {
			super.draw();
		}
		
		/*protected function drawFace():void {
			_face.graphics.clear();
			if ( _down ) {
				_face.graphics.beginFill( Style.BUTTON_DOWN );
			} else {
				_face.graphics.beginFill( Style.BUTTON_FACE );
			}
			_face.graphics.drawRect( 0, 0, _width - 2, _height - 2 );
			_face.graphics.endFill();
		}
		
		override public function draw():void {
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill( Style.BACKGROUND );
			_back.graphics.drawRect( 0, 0, _width, _height );
			_back.graphics.endFill();
			
			drawFace();
			
			_label.text = _labelText;
			_label.autoSize = true;
			_label.draw();
			if ( _label.width > _width - 4 ) {
				_label.autoSize = false;
				_label.width = _width - 4;
			} else {
				_label.autoSize = true;
			}
			_label.draw();
			_label.move( _width / 2 - _label.width / 2, _height / 2 - _label.height / 2 );
		}*/
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver( event:MouseEvent ):void {
			_over = true;
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut( event:MouseEvent ):void {
			_over = false;
			if ( !_down ) {
				//_face.filters = [ getShadow( 1 ) ];
			}
			removeEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown( event:MouseEvent ):void {
			_down = true;
			//drawFace();
			//_face.filters = [ getShadow( 1, true ) ];
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseGoUp );
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp( event:MouseEvent ):void {
			if ( _toggle && _over ) {
				_selected = !_selected;
			}
			_down = _selected;
			//drawFace();
			//_face.filters = [ getShadow( 1, _selected ) ];
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseGoUp );
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set selected( value:Boolean ):void {
			if ( !_toggle ) {
				value = false;
			}
			
			_selected = value;
			_down = _selected;
			//_face.filters = [ getShadow( 1, _selected ) ];
			//drawFace();
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
