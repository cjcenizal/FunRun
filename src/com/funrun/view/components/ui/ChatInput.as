package com.funrun.view.components.ui
{
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	public class ChatInput extends AbstractComponent
	{
		
		[Embed (source="embed/lobby_chat_input.png" )]
		private var Background:Class;
		
		[Embed (source="embed/lobby_chat_input_button.png" )]
		private var ChatButton:Class;
		
		public static const DEFAULT_FONT:String = "ArialRound";
		
		private var _bg:Bitmap;
		private var _button:Sprite;
		protected var _text:String = "";
		protected var _tf:TextField;
		private var _hasFocus:Boolean = false;
		public var onSendChatSignal:Signal;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this InputText.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param text The string containing the initial text of this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function ChatInput(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "", defaultHandler:Function = null)
		{
			this.text = text;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
			
			this.mouseChildren = true;
			
			setSize(380, 33);
			
			_bg = new Background();
			addChild( _bg );
			_bg.x = -35;
			_bg.y = -25;
			
			_button = new Sprite();
			var img:Bitmap = new ChatButton();
			_button.addChild( img );
			addChild( _button );
			_button.x = _width + 22;
			_button.y = 3;
			_button.alpha = .5;
			_button.addEventListener( MouseEvent.MOUSE_OVER, onButtonOver );
			_button.addEventListener( MouseEvent.MOUSE_OUT, onButtonOut );
			_button.addEventListener( MouseEvent.CLICK, onButtonClick );
			
			_tf = new TextField();
			_tf.embedFonts = true;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.defaultTextFormat = new TextFormat( DEFAULT_FONT, 16, 0xffffff );
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE, onChange);
			_tf.addEventListener( FocusEvent.FOCUS_OUT, onLoseFocus );
			_tf.addEventListener( FocusEvent.FOCUS_IN, onGainFocus );
			
			var g:Graphics = this.graphics;
			g.lineStyle( 1, 0xfda315 );
			g.moveTo( _tf.x, _height - 4 );
			g.lineTo( _tf.x + _width, _height - 4 );
			g.endFill();
			
			this.alpha = .5;
			this.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			this.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			this.addEventListener( MouseEvent.CLICK, onClick );
			this.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			onSendChatSignal = new Signal();
		}
		
		private function onOver( e:MouseEvent ):void {
			this.alpha = 1;
		}
		
		private function onOut( e:MouseEvent ):void {
			if ( !_hasFocus ) this.alpha = .5;
		}
		
		private function onClick( e:MouseEvent ):void {
			stage.focus = _tf;
		}
		
		private function onLoseFocus( e:FocusEvent ):void {
			_hasFocus = false;
			alpha = .5;
		}
		
		private function onGainFocus( e:FocusEvent ):void {
			_hasFocus = true;
			this.alpha = 1;
		}
		
		private function onButtonOver( e:MouseEvent ):void {
			_button.alpha = 1;
		}
		
		private function onButtonOut( e:MouseEvent ):void {
			_button.alpha = .5;
		}
		
		private function onButtonClick( e:MouseEvent ):void {
			onSendChatSignal.dispatch();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			if ( e.keyCode == Keyboard.ENTER ) {
				onSendChatSignal.dispatch();
			}
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			if(_text != null)
			{
				_tf.text = _text;
			}
			else 
			{
				_tf.text = "";
			}
			_tf.width = _width - 4;
			if(_tf.text == "")
			{
				_tf.text = "X";
				_tf.height = Math.min(_tf.textHeight + 4, _height);
				_tf.text = "";
			}
			else
			{
				_tf.height = Math.min(_tf.textHeight + 4, _height);
			}
			_tf.x = 2;
			_tf.y = Math.round(_height / 2 - _tf.height / 2);
		}
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal change handler.
		 * @param event The Event passed by the system.
		 */
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			event.stopImmediatePropagation();
			dispatchEvent(event);
		}
		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the text shown in this InputText.
		 */
		public function set text(t:String):void
		{
			_text = t;
			if(_text == null) _text = "";
			invalidate();
		}
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * Gets / sets the maximum number of characters that can be shown in this InputText.
		 */
		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_tf.tabEnabled = value;
		}
		
	}
}